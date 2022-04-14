Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F85500C0E
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 13:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbiDNLYK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 07:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbiDNLYJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 07:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A07F6C1C9;
        Thu, 14 Apr 2022 04:21:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04B8A61629;
        Thu, 14 Apr 2022 11:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16662C385A1;
        Thu, 14 Apr 2022 11:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649935304;
        bh=Mi0NmaWZeKaYxyg4dGx8jZ2PCjxoTACsVmx8xRfqaHU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YzTaeWT01kr4nZk/g9jV4pDkQy1YMWKEyQnQqNYUauIUS9pN+WXE5RmbY7H2Jiv9V
         SmvPidxX/zYblzPk60sZfTeWjXyxzsrpbx1O/UEYbnQEHQ1aW7RybvCkiUSwsWNMYn
         07XDoTInX2x0ZmWfvFSAkafSt+ZklOAjInULJWKkJ7owBPmXk39XRxfhLVI0eeomTG
         SB0/FDytvmr933dbB9xkXfZkSWpS3bP/It4wsE5Xe1CCapt72xHm3Wb/eklQpkRETh
         /GQS/18cvUoNLbTYaVYb1DW97/SYbNrdoD7UcTY8Ddv8DnPpJohofmkXoSgvbGDjaW
         7AcYzmm9TyMWQ==
Message-ID: <8b36c54def8948747a704676491cc18dd08b48e9.camel@kernel.org>
Subject: Re: [PATCH V4 16/31] x86/sgx: Support adding of pages to an
 initialized enclave
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Apr 2022 14:20:36 +0300
In-Reply-To: <2293bdca025ce54bd2996783e187e209f9c0f5f2.1649878359.git.reinette.chatre@intel.com>
References: <cover.1649878359.git.reinette.chatre@intel.com>
         <2293bdca025ce54bd2996783e187e209f9c0f5f2.1649878359.git.reinette.chatre@intel.com>
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
> With SGX1 an enclave needs to be created with its maximum memory demands
> allocated. Pages cannot be added to an enclave after it is initialized.
> SGX2 introduces a new function, ENCLS[EAUG], that can be used to add
> pages to an initialized enclave. With SGX2 the enclave still needs to
> set aside address space for its maximum memory demands during enclave
> creation, but all pages need not be added before enclave initialization.
> Pages can be added during enclave runtime.
>=20
> Add support for dynamically adding pages to an initialized enclave,
> architecturally limited to RW permission at creation but allowed to
> obtain RWX permissions after trusted enclave runs EMODPE. Add pages
> via the page fault handler at the time an enclave address without a
> backing enclave page is accessed, potentially directly reclaiming
> pages if no free pages are available.
>=20
> The enclave is still required to run ENCLU[EACCEPT] on the page before
> it can be used. A useful flow is for the enclave to run ENCLU[EACCEPT]
> on an uninitialized address. This will trigger the page fault handler
> that will add the enclave page and return execution to the enclave to
> repeat the ENCLU[EACCEPT] instruction, this time successful.
>=20
> If the enclave accesses an uninitialized address in another way, for
> example by expanding the enclave stack to a page that has not yet been
> added, then the page fault handler would add the page on the first
> write but upon returning to the enclave the instruction that triggered
> the page fault would be repeated and since ENCLU[EACCEPT] was not run
> yet it would trigger a second page fault, this time with the SGX flag
> set in the page fault error code. This can only be recovered by entering
> the enclave again and directly running the ENCLU[EACCEPT] instruction on
> the now initialized address.
>=20
> Accessing an uninitialized address from outside the enclave also
> triggers this flow but the page will remain inaccessible (access will
> result in #PF) until accepted from within the enclave via
> ENCLU[EACCEPT].
>=20
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

I'm presuming that Haitao tested with this applied, right?

BR, Jarkko
