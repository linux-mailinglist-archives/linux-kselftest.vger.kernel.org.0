Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E56500C08
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 13:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242601AbiDNLXS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 07:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239244AbiDNLXR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 07:23:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A22D252AE;
        Thu, 14 Apr 2022 04:20:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4273B615AB;
        Thu, 14 Apr 2022 11:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BE8C385A1;
        Thu, 14 Apr 2022 11:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649935252;
        bh=iGIdjy7t28ssHBythHS2S4ovbP7pluWdyN+wh107KqA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qzj0PU3tnNlPbSfyQu/lKskXs8gaaLnaH20Hz9CoGBv7J9Hyw2oSc6jh3Gu3dF8qs
         3+JU4F/RNadcnyeI3PA4Qut8eaZim30MVr49nLhr2NCLt5EDxknDg0Nl5jbEyaNm98
         BQj/0nHDAhFoiBsdt8FMoC/im5Oh37jWr6+wa63ERvALemuSThoCYYbkTNXxw3FbeJ
         gSKdu02vbq4VDPZ+x9CzixAKDGib/SOcYcoUHkkK+bfsjT15QCO5+qU7A7lG6nTPzs
         CnUPK8y7PWq350DE7cNma3O8gjzpWbj6odCNMWaNNCrXytPp8VxoBMIF95wDtvdd3/
         OHOfcgokCiSiA==
Message-ID: <7129163a0565dacc4f4f08c03f2cfe061274d017.camel@kernel.org>
Subject: Re: [PATCH V4 15/31] x86/sgx: Support restricting of enclave page
 permissions
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Apr 2022 14:19:44 +0300
In-Reply-To: <9abbecc124d61843c27217bf183d7447a281c297.camel@kernel.org>
References: <cover.1649878359.git.reinette.chatre@intel.com>
         <a1d7820ab5f2e6d21cacb14bafd40a682101c492.1649878359.git.reinette.chatre@intel.com>
         <9abbecc124d61843c27217bf183d7447a281c297.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2022-04-14 at 14:19 +0300, Jarkko Sakkinen wrote:
> On Wed, 2022-04-13 at 14:10 -0700, Reinette Chatre wrote:
> > In the initial (SGX1) version of SGX, pages in an enclave need to be
> > created with permissions that support all usages of the pages, from the
> > time the enclave is initialized until it is unloaded. For example,
> > pages used by a JIT compiler or when code needs to otherwise be
> > relocated need to always have RWX permissions.
> >=20
> > SGX2 includes a new function ENCLS[EMODPR] that is run from the kernel
> > and can be used to restrict the EPCM permissions of regular enclave
> > pages within an initialized enclave.
> >=20
> > Introduce ioctl() SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS to support
> > restricting EPCM permissions. With this ioctl() the user specifies
> > a page range and the EPCM permissions to be applied to all pages in
> > the provided range. ENCLS[EMODPR] is run to restrict the EPCM
> > permissions followed by the ENCLS[ETRACK] flow that will ensure
> > no cached linear-to-physical address mappings to the changed
> > pages remain.
> >=20
> > It is possible for the permission change request to fail on any
> > page within the provided range, either with an error encountered
> > by the kernel or by the SGX hardware while running
> > ENCLS[EMODPR]. To support partial success the ioctl() returns an
> > error code based on failures encountered by the kernel as well
> > as two result output parameters: one for the number of pages
> > that were successfully changed and one for the SGX return code.
> >=20
> > The page table entry permissions are not impacted by the EPCM
> > permission changes. VMAs and PTEs will continue to allow the
> > maximum vetted permissions determined at the time the pages
> > are added to the enclave. The SGX error code in a page fault
> > will indicate if it was an EPCM permission check that prevented
> > an access attempt.
> >=20
> > No checking is done to ensure that the permissions are actually
> > being restricted. This is because the enclave may have relaxed
> > the EPCM permissions from within the enclave without the kernel
> > knowing. An attempt to relax permissions using this call will
> > be ignored by the hardware.
> >=20
> > Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>=20
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Also for this:

Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
