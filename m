Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E244ECD2D
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Mar 2022 21:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241301AbiC3TZd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Mar 2022 15:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbiC3TZb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Mar 2022 15:25:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9D9E30;
        Wed, 30 Mar 2022 12:23:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A92DA614ED;
        Wed, 30 Mar 2022 19:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8C1C340EC;
        Wed, 30 Mar 2022 19:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648668224;
        bh=qfcOtpUmc3V95SnfNZw0AXpV8o0Dw2lu5IoKH3sZ/qI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XV24Srp2S2xWzMRTJVgatiRn+p06buhFMTc4zRn8Sxh6NV1K/TSk9erIS8lDLyg1g
         PBdRbfIzfNXnStlkFpKUNFP/Kws9/hJLUfw1kSOiA9uHC9eifx5LdddDyQlff/GwAo
         1eTCex/FLELjK0a7+LVq1quy9Fi41JlYI/OmQmiwmS7vWt8crH+QuwYDV4M2PJ0bFU
         FtcP4HA++YcVwocQ/mw2aePDwjI6T29a9mmgvtAYbOKPnuNbA4RNpVrj1DN7lGDXK8
         /W4RcU66S0QaVrLCAUNb0aamiog9McfAH09FM/ezJnrkAGXyz58H0u9fBlAtQR+eCf
         C5peulNcfqGVw==
Message-ID: <962cf8bf3544fe3e5d263442bb5ca2e21f25a54b.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] selftests/sgx: Use rip relative addressing for
 encl_stack
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:INTEL SGX" <linux-sgx@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 30 Mar 2022 22:22:43 +0300
In-Reply-To: <f68d472877b7136c32d8770603a3de38de59c322.camel@kernel.org>
References: <20220322074313.7444-1-jarkko@kernel.org>
         <7b7732ec-c7ff-cf92-510f-64c83ed985cd@intel.com> <YkRvFkEO8Ic1VdQ8@iki.fi>
         <0031a4f0-75f6-3104-1825-dcc2528f61b0@intel.com>
         <f68d472877b7136c32d8770603a3de38de59c322.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.4 
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

On Wed, 2022-03-30 at 22:03 +0300, Jarkko Sakkinen wrote:
> On Wed, 2022-03-30 at 10:40 -0700, Reinette Chatre wrote:
> > Could you please elaborate how the compiler will fix it up?
>=20
> Sure.
>=20
> Here's the disassembly of the RBX version:
>=20
> [0x000021a9]> pi 1
> lea rax, [rbx + loc.encl_stack]
>=20
> Here's the same with s/RBX/RIP/:
>=20
> [0x000021a9]> pi 5
> lea rax, loc.encl_stack
> Compiler will substitute correct offset relative to the RIP,
> well, because it can and it makes sense.
>=20
> It is treated differently than other registers, e.g. when
> LEA is assembled.
>=20
> BR, Jarkko


To demonstrate this I did a couple of simple sessions with Rizin
(fork/continuation/something of Radare2):

jarkko@suppilovahvero ~/Downloads (main)> rizin test_encl.rbx.elf
 -- Temporally drop the verbosity prefixing the commands with ':'
[0x00002000]> aaa
[x] Analyze all flags starting with sym. and entry0 (aa)
[x] Analyze function calls (aac)
[x] Analyze len bytes of instructions for references (aar)
[x] Check for classes
[x] Type matching analysis for all functions (aaft)
[x] Propagate noreturn information
[x] Use -AA or aaaa to perform additional experimental analysis.
[0x00002000]> /ad lea
0x0000206e   # 7: lea rax, [rip + 0xf8b]
0x0000206f   # 6: lea eax, [rip + 0xf8b]
0x0000207e   # 1: leave
0x000020a1   # 7: lea rcx, [rip + 0xf58]
0x000020a2   # 6: lea ecx, [rip + 0xf58]
0x000020b4   # 1: leave
0x000020ee   # 1: leave
0x00002128   # 1: leave
0x00002145   # 7: lea rax, [rip - 0x102]
0x00002146   # 6: lea eax, [rip - 0x102]
0x00002150   # 7: lea rax, [rip - 0xd7]
0x00002151   # 6: lea eax, [rip - 0xd7]
0x0000215b   # 7: lea rax, [rip - 0xac]
0x0000215c   # 6: lea eax, [rip - 0xac]
0x00002166   # 7: lea rax, [rip - 0x7d]
0x00002167   # 6: lea eax, [rip - 0x7d]
0x00002171   # 7: lea rax, [rip - 0x4e]
0x00002172   # 6: lea eax, [rip - 0x4e]
0x000021a7   # 1: leave
0x000021a9   # 7: lea rax, [rbx + loc.encl_stack]
0x000021aa   # 6: lea eax, [rbx + loc.encl_stack]
[0x00002000]> s 0x21a9
[0x000021a9]> pi 1
lea rax, [rbx + loc.encl_stack]
[0x000021a9]>=20

jarkko@suppilovahvero ~/Downloads (main)> rizin test_encl.elf
 -- Use V! to enter into the visual panels mode (dwm style)
[0x00002000]> aaa
[x] Analyze all flags starting with sym. and entry0 (aa)
[x] Analyze function calls (aac)
[x] Analyze len bytes of instructions for references (aar)
[x] Check for classes
[x] Type matching analysis for all functions (aaft)
[x] Propagate noreturn information
[x] Use -AA or aaaa to perform additional experimental analysis.
[0x00002000]> /ad lea
0x0000206e   # 7: lea rax, [rip + 0xf8b]
0x0000206f   # 6: lea eax, [rip + 0xf8b]
0x0000207e   # 1: leave
0x000020a1   # 7: lea rcx, [rip + 0xf58]
0x000020a2   # 6: lea ecx, [rip + 0xf58]
0x000020b4   # 1: leave
0x000020ee   # 1: leave
0x00002128   # 1: leave
0x00002145   # 7: lea rax, [rip - 0x102]
0x00002146   # 6: lea eax, [rip - 0x102]
0x00002150   # 7: lea rax, [rip - 0xd7]
0x00002151   # 6: lea eax, [rip - 0xd7]
0x0000215b   # 7: lea rax, [rip - 0xac]
0x0000215c   # 6: lea eax, [rip - 0xac]
0x00002166   # 7: lea rax, [rip - 0x7d]
0x00002167   # 6: lea eax, [rip - 0x7d]
0x00002171   # 7: lea rax, [rip - 0x4e]
0x00002172   # 6: lea eax, [rip - 0x4e]
0x000021a7   # 1: leave
0x000021a9   # 7: lea rax, [rip + 0x5e50]
0x000021aa   # 6: lea eax, [rip + 0x5e50]
[0x00002000]> s 0x21a9
[0x000021a9]> pi 1
lea rax, loc.encl_stack
[0x000021a9]>=20

BR, Jarkko
