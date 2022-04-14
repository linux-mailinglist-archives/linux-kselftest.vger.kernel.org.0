Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFACD500C0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 13:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbiDNLYx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 07:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbiDNLYw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 07:24:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1676482316;
        Thu, 14 Apr 2022 04:22:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A60F36163D;
        Thu, 14 Apr 2022 11:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E79C385A8;
        Thu, 14 Apr 2022 11:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649935347;
        bh=CVGUKCib9zFBI0T2prw/tB5KO7x6OuH4EIewfTZP//E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ms+cE6I6w+ny45EasJ6+gOK6UIc2GIsF3BvO1MQrvS5b+tpZaxBmi7YqpGgiO7+rI
         gNS7AJGJcASUiZnEsr26zxJX31NKhDsIrcI4516QynQdTAAIi1EBisVFb+y8+rWDha
         C1sy0ETJAUCtFVpRCUWT35TcRtH1iBnaWJlhpEroxVWNxlcx5AGxHACF4myZdfSjxz
         cisuvfSnGVKYMbFI1QxcVsg0Zds6ta9VDt++dGRth2XaYnJML1SYx4OdVWrrY0kQdY
         yfuoZo1ev1CDS4suwp/CoN+hp9gJx/yoevo48JRVbQjQh9FJyjbIBylv6oDwYyW8mN
         KAR568VnxhnIw==
Message-ID: <c0e3765e0b82beb9b4f1ae1d7ef879abd923e063.camel@kernel.org>
Subject: Re: [PATCH V4 21/31] Documentation/x86: Introduce enclave runtime
 management section
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Apr 2022 14:21:19 +0300
In-Reply-To: <21b97a8e9275706f14d6bc652a0f2cfdd5d9648e.1649878359.git.reinette.chatre@intel.com>
References: <cover.1649878359.git.reinette.chatre@intel.com>
         <21b97a8e9275706f14d6bc652a0f2cfdd5d9648e.1649878359.git.reinette.chatre@intel.com>
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
> Enclave runtime management is introduced following the pattern
> of the section describing enclave building. Provide a brief
> summary of enclave runtime management, pointing to the functions
> implementing the ioctl()s that will contain details within their
> kernel-doc.
>=20
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> No changes since V3.
>=20
> Changes since V2:
> - Remove references to ioctl() to relax permissions and update to reflect
> =C2=A0 function renaming sgx_ioc_enclave_restrict_perm() ->
> =C2=A0 sgx_ioc_enclave_restrict_permissions().
> - Rename sgx_ioc_enclave_modt -> sgx_ioc_enclave_modify_type
>=20
> Changes since V1:
> - New patch.
>=20
> =C2=A0Documentation/x86/sgx.rst | 15 +++++++++++++++
> =C2=A01 file changed, 15 insertions(+)
>=20
> diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
> index 265568a9292c..10287c558485 100644
> --- a/Documentation/x86/sgx.rst
> +++ b/Documentation/x86/sgx.rst
> @@ -100,6 +100,21 @@ pages and establish enclave page permissions.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sgx_ioc_enclave_init
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sgx_ioc_enclave_provision
> =C2=A0
> +Enclave runtime management
> +--------------------------
> +
> +Systems supporting SGX2 additionally support changes to initialized
> +enclaves: modifying enclave page permissions and type, and dynamically
> +adding and removing of enclave pages. When an enclave accesses an addres=
s
> +within its address range that does not have a backing page then a new
> +regular page will be dynamically added to the enclave. The enclave is
> +still required to run EACCEPT on the new page before it can be used.
> +
> +.. kernel-doc:: arch/x86/kernel/cpu/sgx/ioctl.c
> +=C2=A0=C2=A0 :functions: sgx_ioc_enclave_restrict_permissions
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 sgx_ioc_enclave_modify_type
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 sgx_ioc_enclave_remove_pages
> +
> =C2=A0Enclave vDSO
> =C2=A0------------
> =C2=A0

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

