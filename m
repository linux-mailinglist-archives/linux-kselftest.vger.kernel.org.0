Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2005958BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Aug 2022 12:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbiHPKpK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Aug 2022 06:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbiHPKox (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Aug 2022 06:44:53 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C62D422D9;
        Tue, 16 Aug 2022 03:05:38 -0700 (PDT)
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oNtRe-000AM5-2C; Tue, 16 Aug 2022 12:05:10 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oNtRd-000Rzb-C5; Tue, 16 Aug 2022 12:05:09 +0200
Subject: Re: [PATCH v11 0/9] bpf: Add kfuncs for PKCS#7 signature verification
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "mykolal@fb.com" <mykolal@fb.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "shuah@kernel.org" <shuah@kernel.org>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220812101902.2846182-1-roberto.sassu@huawei.com>
 <14032690-e7a9-9d14-1ec1-14dd3503037c@iogearbox.net>
 <b61eb3b95843409eb6ab03aea4a0ca30@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <be1fdbba-73ba-3106-622e-57ef5f471a26@iogearbox.net>
Date:   Tue, 16 Aug 2022 12:05:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <b61eb3b95843409eb6ab03aea4a0ca30@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26629/Tue Aug 16 09:51:41 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/16/22 9:12 AM, Roberto Sassu wrote:
>> From: Daniel Borkmann [mailto:daniel@iogearbox.net]
>> Sent: Monday, August 15, 2022 6:10 PM
>> On 8/12/22 12:18 PM, Roberto Sassu wrote:
>>> One of the desirable features in security is the ability to restrict import
>>> of data to a given system based on data authenticity. If data import can be
>>> restricted, it would be possible to enforce a system-wide policy based on
>>> the signing keys the system owner trusts.
>>>
>> [...]
>>> Changelog
>>>
>>> v10:
>>>    - Introduce key_lookup_flags_check() and system_keyring_id_check() inline
>>>      functions to check parameters (suggested by KP)
>>>    - Fix descriptions and comment of key-related kfuncs (suggested by KP)
>>>    - Register kfunc set only once (suggested by Alexei)
>>>    - Move needed kernel options to the architecture-independent configuration
>>>      for testing
>>
>> Looks like from BPF CI side, the selftest throws a WARN in test_progs /
>> test_progs-no_alu32
>> and subsequently fails with error, ptal:
>>
>>     https://github.com/kernel-
>> patches/bpf/runs/7804422038?check_suite_focus=true
> 
> it is due to the missing SHA256 kernel module (not copied to
> the virtual machine).
> 
> I made a small patch in libbpf/ci to change kernel options =m
> into =y. With that patch, my instance of vmtest gives success
> (except for z15, which requires adding openssl and keyctl
> to the virtual machine image).

The code in pkcs1pad_verify() triggering the warning is:

     [...]
         if (WARN_ON(req->dst) || WARN_ON(!digest_size) ||
             !ctx->key_size || sig_size != ctx->key_size)
                 return -EINVAL;
     [...]

It is not obvious at all to users that sha256 module is missing in their kernel,
how will they be able to figure it out?

Should the helper be gated if dependency is not available, or return a -EOPNOTSUPP
if the specific request cannot be satisfied (but others can..)?

>>     [...]
>>     #235     verif_scale_xdp_loop:OK
>>     #236     verif_stats:OK
>>     #237     verif_twfw:OK
>>     [  760.448652] ------------[ cut here ]------------
>>     [  760.449506] WARNING: CPU: 3 PID: 930 at crypto/rsa-pkcs1pad.c:544
>> pkcs1pad_verify+0x184/0x190
>>     [  760.450806] Modules linked in: bpf_testmod(OE) [last unloaded:
>> bpf_testmod]
>>     [  760.452340] CPU: 3 PID: 930 Comm: keyctl Tainted: G           OE      5.19.0-
>> g9f0260338e31-dirty #1
>>     [  760.453626] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> 1.13.0-1ubuntu1.1 04/01/2014
>>     [  760.454801] RIP: 0010:pkcs1pad_verify+0x184/0x190
>>     [  760.455380] Code: 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 48 89 df 89 c6 5b 41
>> 5c 41 5d 41 5e 41 5f 5d e9 a5 04 00 00 0f 0b b8 ea ff ff ff eb d4 <0f> 0b b8 ea ff
>> ff ff eb cb 0f 0b 90 0f 1f 44 00 00 53 48 89 fb c7
>>     [  760.456866] RSP: 0018:ffffad55478dbb58 EFLAGS: 00000246
>>     [  760.457684] RAX: ffff9b3c43c42458 RBX: ffff9b3c48975b00 RCX:
>> 0000000000000000
>>     [  760.458672] RDX: ffffffffa7277438 RSI: ffffffffa5275510 RDI:
>> 0000000000000000
>>     [  760.459670] RBP: ffffad55478dbcf8 R08: 0000000000000002 R09:
>> 0000000000000000
>>     [  760.460688] R10: ffffad55478dbc20 R11: ffffffffa44dde10 R12:
>> ffff9b3c43de2e80
>>     [  760.461695] R13: ffff9b3c58459ea0 R14: ffff9b3c44d59600 R15:
>> ffffad55478dbc20
>>     [  760.462270] FS:  00007ff1ee0eb740(0000) GS:ffff9b3cf9cc0000(0000)
>> knlGS:0000000000000000
>>     [  760.462722] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>     [  760.463026] CR2: 000055b9a4c17588 CR3: 0000000107bb2000 CR4:
>> 00000000000006e0
>>     [  760.464039] Call Trace:
>>     [  760.464465]  <TASK>
>>     [  760.464749]  public_key_verify_signature+0x4a2/0x570
>>     [  760.465623]  x509_check_for_self_signed+0x4e/0xd0
>>     [  760.465937]  x509_cert_parse+0x193/0x220
>>     [  760.466656]  x509_key_preparse+0x20/0x1f0
>>     [  760.466975]  asymmetric_key_preparse+0x43/0x80
>>     [  760.467552]  key_create_or_update+0x24e/0x510
>>     [  760.468366]  __x64_sys_add_key+0x19b/0x220
>>     [  760.468704]  ? syscall_enter_from_user_mode+0x24/0x1f0
>>     [  760.469056]  do_syscall_64+0x43/0x90
>>     [  760.469657]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>     [  760.470413] RIP: 0033:0x7ff1edf0ba9d
>>     [  760.470832] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8
>> 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
>> ff 73 01 c3 48 8b 0d cb e2 0e 00 f7 d8 64 89 01 48
>>     [  760.472742] RSP: 002b:00007ffe635e7a18 EFLAGS: 00000246 ORIG_RAX:
>> 00000000000000f8
>>     [  760.473355] RAX: ffffffffffffffda RBX: 00007ffe635e7be0 RCX:
>> 00007ff1edf0ba9d
>>     [  760.474523] RDX: 000055982fed80c0 RSI: 00007ffe635e7f17 RDI:
>> 00007ffe635e7f0c
>>     [  760.475500] RBP: 00007ffe635e7a38 R08: 00000000fffffffd R09:
>> 0000000000000000
>>     [  760.475913] R10: 0000000000000355 R11: 0000000000000246 R12:
>> 0000000000000000
>>     [  760.476594] R13: 00007ffe635e7bd8 R14: 000055982fed48ae R15:
>> 000055982fed76e8
>>     [  760.477579]  </TASK>
>>     [  760.477769] irq event stamp: 4727
>>     [  760.477963] hardirqs last  enabled at (4735): [<ffffffffa4101df5>]
>> __up_console_sem+0x75/0xa0
>>     [  760.479036] hardirqs last disabled at (4744): [<ffffffffa4a31cca>]
>> sysvec_apic_timer_interrupt+0xa/0xb0
>>     [  760.480403] softirqs last  enabled at (4762): [<ffffffffa4085172>]
>> __irq_exit_rcu+0xb2/0x140
>>     [  760.480869] softirqs last disabled at (4755): [<ffffffffa4085172>]
>> __irq_exit_rcu+0xb2/0x140
>>     [  760.481706] ---[ end trace 0000000000000000 ]---
>>     Generating a RSA private key
>>     .+++++
>>     ..................................................+++++
>>     writing new private key to '/tmp/verify_sigXdOL5V/signing_key.pem'
>>     -----
>>     add_key: Invalid argument
>>     test_verify_pkcs7_sig:PASS:mkdtemp 0 nsec
>>     test_verify_pkcs7_sig:FAIL:_run_setup_process unexpected error: 1 (errno
>> 126)
>>     #238     verify_pkcs7_sig:FAIL
>>     #239     vmlinux:OK
>>     #240     xdp:OK
>>     #241/1   xdp_adjust_frags/xdp_adjust_frags:OK
>>     #241     xdp_adjust_frags:OK
>>     #242/1   xdp_adjust_tail/xdp_adjust_tail_shrink:OK
>>     #242/2   xdp_adjust_tail/xdp_adjust_tail_grow:OK
>>     [...]

