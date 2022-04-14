Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42907500C05
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 13:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbiDNLWk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 07:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242646AbiDNLWi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 07:22:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A10A27FE2;
        Thu, 14 Apr 2022 04:20:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E861BB82931;
        Thu, 14 Apr 2022 11:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531A6C385A1;
        Thu, 14 Apr 2022 11:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649935208;
        bh=eTpWQLD9rr23+ee1ohaCLL6Wia7a8J0Io+jqTPdu7O4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hUCoKV0oQZ1mmZcwEkGsl19vxtLiI1VrOYjPyrvJs5T2lIWNA9O+cTL5Ekay7XDWd
         cG/1e6LkBfCmW0KJXVvb6d4IkvXSzXozn0hEtIxz+lgq83xMZ+Y7GI753MmsjTRUP7
         3ZQvXWBV089KName3Uu9UBXGLrKNUyz3JxjvLLjCrv/F+un4FRcU+Er39hW0uMK7xD
         WrhpiztpnndkJPKtKJxi95sS3i9NSvGNQEBcmOtVlxPbW2dwRijRbmEs3X1S/8jHTa
         KiP9FfmPuX9uHMQuCEcwiFbSx8ud7WpKhvCSl5u0XvApXmwKKO6CdzluUM4cMXXg2s
         Ugc+XgBZf1Nqw==
Message-ID: <9abbecc124d61843c27217bf183d7447a281c297.camel@kernel.org>
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
Date:   Thu, 14 Apr 2022 14:19:00 +0300
In-Reply-To: <a1d7820ab5f2e6d21cacb14bafd40a682101c492.1649878359.git.reinette.chatre@intel.com>
References: <cover.1649878359.git.reinette.chatre@intel.com>
         <a1d7820ab5f2e6d21cacb14bafd40a682101c492.1649878359.git.reinette.chatre@intel.com>
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

On Wed, 2022-04-13 at 14:10 -0700, Reinette Chatre wrote:
> In the initial (SGX1) version of SGX, pages in an enclave need to be
> created with permissions that support all usages of the pages, from the
> time the enclave is initialized until it is unloaded. For example,
> pages used by a JIT compiler or when code needs to otherwise be
> relocated need to always have RWX permissions.
>=20
> SGX2 includes a new function ENCLS[EMODPR] that is run from the kernel
> and can be used to restrict the EPCM permissions of regular enclave
> pages within an initialized enclave.
>=20
> Introduce ioctl() SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS to support
> restricting EPCM permissions. With this ioctl() the user specifies
> a page range and the EPCM permissions to be applied to all pages in
> the provided range. ENCLS[EMODPR] is run to restrict the EPCM
> permissions followed by the ENCLS[ETRACK] flow that will ensure
> no cached linear-to-physical address mappings to the changed
> pages remain.
>=20
> It is possible for the permission change request to fail on any
> page within the provided range, either with an error encountered
> by the kernel or by the SGX hardware while running
> ENCLS[EMODPR]. To support partial success the ioctl() returns an
> error code based on failures encountered by the kernel as well
> as two result output parameters: one for the number of pages
> that were successfully changed and one for the SGX return code.
>=20
> The page table entry permissions are not impacted by the EPCM
> permission changes. VMAs and PTEs will continue to allow the
> maximum vetted permissions determined at the time the pages
> are added to the enclave. The SGX error code in a page fault
> will indicate if it was an EPCM permission check that prevented
> an access attempt.
>=20
> No checking is done to ensure that the permissions are actually
> being restricted. This is because the enclave may have relaxed
> the EPCM permissions from within the enclave without the kernel
> knowing. An attempt to relax permissions using this call will
> be ignored by the hardware.
>=20
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
