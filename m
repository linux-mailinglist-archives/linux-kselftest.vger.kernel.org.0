Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD24797EF4
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 01:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbjIGXGB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Sep 2023 19:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbjIGXGA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Sep 2023 19:06:00 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCBDCF3;
        Thu,  7 Sep 2023 16:05:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-401da71b85eso15739785e9.1;
        Thu, 07 Sep 2023 16:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694127952; x=1694732752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XaMCKcMEdBViAjXTUruxNbmmXo7b8BJjzaE2vXfuL7c=;
        b=Aen0OE+3b8k26kFKDvqCncpzj30K0gljpnopV/MHBzKhwW/Ldkz5PzHSoLM2Blp3ln
         yEevJi/8MIoeD0fmJnK31fk5c3GEDzB5HnKKrgRBSBxNfIxAuVHpMZ+uHpwdREvmDtnx
         2gP3oUDNL5BjaNSG6YoGcaVgaD/o/P/1peEbqEsRtUN4ZkTqBIhuuf30Fp9qlL4rCukj
         IdWlYvFw5gnP25s/aTJqZ5XrixWHV5B8G9TTb3XiR0+3L72GAhIuuUyg89szu0aOkVMB
         iFJ1egZEH3GTdmCBTUxbMwrZq/jsy683RuCa/sNOUeioSIS8jRNDlOVGCWY1xuOBjZ3S
         TlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694127952; x=1694732752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XaMCKcMEdBViAjXTUruxNbmmXo7b8BJjzaE2vXfuL7c=;
        b=lsOsudNG0M3q4s62HW4Kpnjxve/h0kpVFST3FKxECxvvddeui+jP7aFujy1qUuT8yT
         eVr4w6uJjShOcs4azUmwajTNuE9BEQzeCLSAjvQCpsb35QPGv5YMsEUGF/fmqfkFeQTd
         tsU10D/CA0vBIJwfhKMrQ/cswDjIyFMQMo+hPyIpmDv2JEz+3+SeHDTU8wo+TDw7AOek
         rz+WNT4xzf5UPJgt04lrLx6ND8Op+QGTr739x+9DpCytYbFlamXZuGTqiZkRKlFwReex
         ttf3VpZmqm6F7UO9nyBmhR2+2NBajdByTEqrJtcRQpSTRZodQBo6YtV3OblWgbBS+8RB
         RVfA==
X-Gm-Message-State: AOJu0YxjCSxalKcDFzvYnEAC24Sl93xF1kM9nJFkHewCkgcnzPxT4VhV
        VyBW41chMk3LbhaGOxGCkuF934+o1OaqDnMMoQfo7Q==
X-Google-Smtp-Source: AGHT+IGzF/mixcpVmnJ5BgydJj3Jf0JAILARrNe+xCuOmg5UNZm40LUB2Jdx6KOQwm22+RrSEL1MGQ==
X-Received: by 2002:a5d:42c1:0:b0:317:51da:83b9 with SMTP id t1-20020a5d42c1000000b0031751da83b9mr449002wrr.49.1694127952054;
        Thu, 07 Sep 2023 16:05:52 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-3-249-32-32.eu-west-1.compute.amazonaws.com. [3.249.32.32])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d484d000000b0031f3b04e7cdsm491358wrs.109.2023.09.07.16.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 16:05:51 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     puranjay12@gmail.com
Subject: [PATCH bpf-next v3 0/9] arm32, bpf: add support for cpuv4 insns
Date:   Thu,  7 Sep 2023 23:05:41 +0000
Message-Id: <20230907230550.1417590-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changes in V2 -> V3
- Added comments at places where there could be confustion.
- In the patch for DIV64, fix the if-else case that would never run.
- In the same patch use a single instruction to POP caller saved regs.
- Add a patch to change maintainership of ARM32 BPF JIT.

Changes in V1 -> V2:
- Fix coding style issues.
- Don't use tmp variable for src in emit_ldsx_r() as it is redundant.
- Optimize emit_ldsx_r() when offset can fit in immediate.

Add the support for cpuv4 instructions for ARM32 BPF JIT. 64-bit division
was not supported earlier so this series adds 64-bit DIV, SDIV, MOD, SMOD
instructions as well.

This series needs any one of the patches from [1] to disable zero-extension
for BPF_MEMSX to support ldsx.

The relevant selftests have passed expect ldsx_insn which needs fentry:

Tested on BeagleBone Black (ARMv7-A):

[root@alarm del]# echo 1 > /proc/sys/net/core/bpf_jit_enable
[root@alarm del]# ./test_progs -a verifier_sdiv,verifier_movsx,verifier_ldsx,verifier_gotol,verifier_bswap
#337/1   verifier_bswap/BSWAP, 16:OK
#337/2   verifier_bswap/BSWAP, 16 @unpriv:OK
#337/3   verifier_bswap/BSWAP, 32:OK
#337/4   verifier_bswap/BSWAP, 32 @unpriv:OK
#337/5   verifier_bswap/BSWAP, 64:OK
#337/6   verifier_bswap/BSWAP, 64 @unpriv:OK
#337     verifier_bswap:OK
#351/1   verifier_gotol/gotol, small_imm:OK
#351/2   verifier_gotol/gotol, small_imm @unpriv:OK
#351     verifier_gotol:OK
#359/1   verifier_ldsx/LDSX, S8:OK
#359/2   verifier_ldsx/LDSX, S8 @unpriv:OK
#359/3   verifier_ldsx/LDSX, S16:OK
#359/4   verifier_ldsx/LDSX, S16 @unpriv:OK
#359/5   verifier_ldsx/LDSX, S32:OK
#359/6   verifier_ldsx/LDSX, S32 @unpriv:OK
#359/7   verifier_ldsx/LDSX, S8 range checking, privileged:OK
#359/8   verifier_ldsx/LDSX, S16 range checking:OK
#359/9   verifier_ldsx/LDSX, S16 range checking @unpriv:OK
#359/10  verifier_ldsx/LDSX, S32 range checking:OK
#359/11  verifier_ldsx/LDSX, S32 range checking @unpriv:OK
#359     verifier_ldsx:OK
#370/1   verifier_movsx/MOV32SX, S8:OK
#370/2   verifier_movsx/MOV32SX, S8 @unpriv:OK
#370/3   verifier_movsx/MOV32SX, S16:OK
#370/4   verifier_movsx/MOV32SX, S16 @unpriv:OK
#370/5   verifier_movsx/MOV64SX, S8:OK
#370/6   verifier_movsx/MOV64SX, S8 @unpriv:OK
#370/7   verifier_movsx/MOV64SX, S16:OK
#370/8   verifier_movsx/MOV64SX, S16 @unpriv:OK
#370/9   verifier_movsx/MOV64SX, S32:OK
#370/10  verifier_movsx/MOV64SX, S32 @unpriv:OK
#370/11  verifier_movsx/MOV32SX, S8, range_check:OK
#370/12  verifier_movsx/MOV32SX, S8, range_check @unpriv:OK
#370/13  verifier_movsx/MOV32SX, S16, range_check:OK
#370/14  verifier_movsx/MOV32SX, S16, range_check @unpriv:OK
#370/15  verifier_movsx/MOV32SX, S16, range_check 2:OK
#370/16  verifier_movsx/MOV32SX, S16, range_check 2 @unpriv:OK
#370/17  verifier_movsx/MOV64SX, S8, range_check:OK
#370/18  verifier_movsx/MOV64SX, S8, range_check @unpriv:OK
#370/19  verifier_movsx/MOV64SX, S16, range_check:OK
#370/20  verifier_movsx/MOV64SX, S16, range_check @unpriv:OK
#370/21  verifier_movsx/MOV64SX, S32, range_check:OK
#370/22  verifier_movsx/MOV64SX, S32, range_check @unpriv:OK
#370/23  verifier_movsx/MOV64SX, S16, R10 Sign Extension:OK
#370/24  verifier_movsx/MOV64SX, S16, R10 Sign Extension @unpriv:OK
#370     verifier_movsx:OK
#382/1   verifier_sdiv/SDIV32, non-zero imm divisor, check 1:OK
#382/2   verifier_sdiv/SDIV32, non-zero imm divisor, check 1 @unpriv:OK
#382/3   verifier_sdiv/SDIV32, non-zero imm divisor, check 2:OK
#382/4   verifier_sdiv/SDIV32, non-zero imm divisor, check 2 @unpriv:OK
#382/5   verifier_sdiv/SDIV32, non-zero imm divisor, check 3:OK
#382/6   verifier_sdiv/SDIV32, non-zero imm divisor, check 3 @unpriv:OK
#382/7   verifier_sdiv/SDIV32, non-zero imm divisor, check 4:OK
#382/8   verifier_sdiv/SDIV32, non-zero imm divisor, check 4 @unpriv:OK
#382/9   verifier_sdiv/SDIV32, non-zero imm divisor, check 5:OK
#382/10  verifier_sdiv/SDIV32, non-zero imm divisor, check 5 @unpriv:OK
#382/11  verifier_sdiv/SDIV32, non-zero imm divisor, check 6:OK
#382/12  verifier_sdiv/SDIV32, non-zero imm divisor, check 6 @unpriv:OK
#382/13  verifier_sdiv/SDIV32, non-zero imm divisor, check 7:OK
#382/14  verifier_sdiv/SDIV32, non-zero imm divisor, check 7 @unpriv:OK
#382/15  verifier_sdiv/SDIV32, non-zero imm divisor, check 8:OK
#382/16  verifier_sdiv/SDIV32, non-zero imm divisor, check 8 @unpriv:OK
#382/17  verifier_sdiv/SDIV32, non-zero reg divisor, check 1:OK
#382/18  verifier_sdiv/SDIV32, non-zero reg divisor, check 1 @unpriv:OK
#382/19  verifier_sdiv/SDIV32, non-zero reg divisor, check 2:OK
#382/20  verifier_sdiv/SDIV32, non-zero reg divisor, check 2 @unpriv:OK
#382/21  verifier_sdiv/SDIV32, non-zero reg divisor, check 3:OK
#382/22  verifier_sdiv/SDIV32, non-zero reg divisor, check 3 @unpriv:OK
#382/23  verifier_sdiv/SDIV32, non-zero reg divisor, check 4:OK
#382/24  verifier_sdiv/SDIV32, non-zero reg divisor, check 4 @unpriv:OK
#382/25  verifier_sdiv/SDIV32, non-zero reg divisor, check 5:OK
#382/26  verifier_sdiv/SDIV32, non-zero reg divisor, check 5 @unpriv:OK
#382/27  verifier_sdiv/SDIV32, non-zero reg divisor, check 6:OK
#382/28  verifier_sdiv/SDIV32, non-zero reg divisor, check 6 @unpriv:OK
#382/29  verifier_sdiv/SDIV32, non-zero reg divisor, check 7:OK
#382/30  verifier_sdiv/SDIV32, non-zero reg divisor, check 7 @unpriv:OK
#382/31  verifier_sdiv/SDIV32, non-zero reg divisor, check 8:OK
#382/32  verifier_sdiv/SDIV32, non-zero reg divisor, check 8 @unpriv:OK
#382/33  verifier_sdiv/SDIV64, non-zero imm divisor, check 1:OK
#382/34  verifier_sdiv/SDIV64, non-zero imm divisor, check 1 @unpriv:OK
#382/35  verifier_sdiv/SDIV64, non-zero imm divisor, check 2:OK
#382/36  verifier_sdiv/SDIV64, non-zero imm divisor, check 2 @unpriv:OK
#382/37  verifier_sdiv/SDIV64, non-zero imm divisor, check 3:OK
#382/38  verifier_sdiv/SDIV64, non-zero imm divisor, check 3 @unpriv:OK
#382/39  verifier_sdiv/SDIV64, non-zero imm divisor, check 4:OK
#382/40  verifier_sdiv/SDIV64, non-zero imm divisor, check 4 @unpriv:OK
#382/41  verifier_sdiv/SDIV64, non-zero imm divisor, check 5:OK
#382/42  verifier_sdiv/SDIV64, non-zero imm divisor, check 5 @unpriv:OK
#382/43  verifier_sdiv/SDIV64, non-zero imm divisor, check 6:OK
#382/44  verifier_sdiv/SDIV64, non-zero imm divisor, check 6 @unpriv:OK
#382/45  verifier_sdiv/SDIV64, non-zero reg divisor, check 1:OK
#382/46  verifier_sdiv/SDIV64, non-zero reg divisor, check 1 @unpriv:OK
#382/47  verifier_sdiv/SDIV64, non-zero reg divisor, check 2:OK
#382/48  verifier_sdiv/SDIV64, non-zero reg divisor, check 2 @unpriv:OK
#382/49  verifier_sdiv/SDIV64, non-zero reg divisor, check 3:OK
#382/50  verifier_sdiv/SDIV64, non-zero reg divisor, check 3 @unpriv:OK
#382/51  verifier_sdiv/SDIV64, non-zero reg divisor, check 4:OK
#382/52  verifier_sdiv/SDIV64, non-zero reg divisor, check 4 @unpriv:OK
#382/53  verifier_sdiv/SDIV64, non-zero reg divisor, check 5:OK
#382/54  verifier_sdiv/SDIV64, non-zero reg divisor, check 5 @unpriv:OK
#382/55  verifier_sdiv/SDIV64, non-zero reg divisor, check 6:OK
#382/56  verifier_sdiv/SDIV64, non-zero reg divisor, check 6 @unpriv:OK
#382/57  verifier_sdiv/SMOD32, non-zero imm divisor, check 1:OK
#382/58  verifier_sdiv/SMOD32, non-zero imm divisor, check 1 @unpriv:OK
#382/59  verifier_sdiv/SMOD32, non-zero imm divisor, check 2:OK
#382/60  verifier_sdiv/SMOD32, non-zero imm divisor, check 2 @unpriv:OK
#382/61  verifier_sdiv/SMOD32, non-zero imm divisor, check 3:OK
#382/62  verifier_sdiv/SMOD32, non-zero imm divisor, check 3 @unpriv:OK
#382/63  verifier_sdiv/SMOD32, non-zero imm divisor, check 4:OK
#382/64  verifier_sdiv/SMOD32, non-zero imm divisor, check 4 @unpriv:OK
#382/65  verifier_sdiv/SMOD32, non-zero imm divisor, check 5:OK
#382/66  verifier_sdiv/SMOD32, non-zero imm divisor, check 5 @unpriv:OK
#382/67  verifier_sdiv/SMOD32, non-zero imm divisor, check 6:OK
#382/68  verifier_sdiv/SMOD32, non-zero imm divisor, check 6 @unpriv:OK
#382/69  verifier_sdiv/SMOD32, non-zero reg divisor, check 1:OK
#382/70  verifier_sdiv/SMOD32, non-zero reg divisor, check 1 @unpriv:OK
#382/71  verifier_sdiv/SMOD32, non-zero reg divisor, check 2:OK
#382/72  verifier_sdiv/SMOD32, non-zero reg divisor, check 2 @unpriv:OK
#382/73  verifier_sdiv/SMOD32, non-zero reg divisor, check 3:OK
#382/74  verifier_sdiv/SMOD32, non-zero reg divisor, check 3 @unpriv:OK
#382/75  verifier_sdiv/SMOD32, non-zero reg divisor, check 4:OK
#382/76  verifier_sdiv/SMOD32, non-zero reg divisor, check 4 @unpriv:OK
#382/77  verifier_sdiv/SMOD32, non-zero reg divisor, check 5:OK
#382/78  verifier_sdiv/SMOD32, non-zero reg divisor, check 5 @unpriv:OK
#382/79  verifier_sdiv/SMOD32, non-zero reg divisor, check 6:OK
#382/80  verifier_sdiv/SMOD32, non-zero reg divisor, check 6 @unpriv:OK
#382/81  verifier_sdiv/SMOD64, non-zero imm divisor, check 1:OK
#382/82  verifier_sdiv/SMOD64, non-zero imm divisor, check 1 @unpriv:OK
#382/83  verifier_sdiv/SMOD64, non-zero imm divisor, check 2:OK
#382/84  verifier_sdiv/SMOD64, non-zero imm divisor, check 2 @unpriv:OK
#382/85  verifier_sdiv/SMOD64, non-zero imm divisor, check 3:OK
#382/86  verifier_sdiv/SMOD64, non-zero imm divisor, check 3 @unpriv:OK
#382/87  verifier_sdiv/SMOD64, non-zero imm divisor, check 4:OK
#382/88  verifier_sdiv/SMOD64, non-zero imm divisor, check 4 @unpriv:OK
#382/89  verifier_sdiv/SMOD64, non-zero imm divisor, check 5:OK
#382/90  verifier_sdiv/SMOD64, non-zero imm divisor, check 5 @unpriv:OK
#382/91  verifier_sdiv/SMOD64, non-zero imm divisor, check 6:OK
#382/92  verifier_sdiv/SMOD64, non-zero imm divisor, check 6 @unpriv:OK
#382/93  verifier_sdiv/SMOD64, non-zero imm divisor, check 7:OK
#382/94  verifier_sdiv/SMOD64, non-zero imm divisor, check 7 @unpriv:OK
#382/95  verifier_sdiv/SMOD64, non-zero imm divisor, check 8:OK
#382/96  verifier_sdiv/SMOD64, non-zero imm divisor, check 8 @unpriv:OK
#382/97  verifier_sdiv/SMOD64, non-zero reg divisor, check 1:OK
#382/98  verifier_sdiv/SMOD64, non-zero reg divisor, check 1 @unpriv:OK
#382/99  verifier_sdiv/SMOD64, non-zero reg divisor, check 2:OK
#382/100 verifier_sdiv/SMOD64, non-zero reg divisor, check 2 @unpriv:OK
#382/101 verifier_sdiv/SMOD64, non-zero reg divisor, check 3:OK
#382/102 verifier_sdiv/SMOD64, non-zero reg divisor, check 3 @unpriv:OK
#382/103 verifier_sdiv/SMOD64, non-zero reg divisor, check 4:OK
#382/104 verifier_sdiv/SMOD64, non-zero reg divisor, check 4 @unpriv:OK
#382/105 verifier_sdiv/SMOD64, non-zero reg divisor, check 5:OK
#382/106 verifier_sdiv/SMOD64, non-zero reg divisor, check 5 @unpriv:OK
#382/107 verifier_sdiv/SMOD64, non-zero reg divisor, check 6:OK
#382/108 verifier_sdiv/SMOD64, non-zero reg divisor, check 6 @unpriv:OK
#382/109 verifier_sdiv/SMOD64, non-zero reg divisor, check 7:OK
#382/110 verifier_sdiv/SMOD64, non-zero reg divisor, check 7 @unpriv:OK
#382/111 verifier_sdiv/SMOD64, non-zero reg divisor, check 8:OK
#382/112 verifier_sdiv/SMOD64, non-zero reg divisor, check 8 @unpriv:OK
#382/113 verifier_sdiv/SDIV32, zero divisor:OK
#382/114 verifier_sdiv/SDIV32, zero divisor @unpriv:OK
#382/115 verifier_sdiv/SDIV64, zero divisor:OK
#382/116 verifier_sdiv/SDIV64, zero divisor @unpriv:OK
#382/117 verifier_sdiv/SMOD32, zero divisor:OK
#382/118 verifier_sdiv/SMOD32, zero divisor @unpriv:OK
#382/119 verifier_sdiv/SMOD64, zero divisor:OK
#382/120 verifier_sdiv/SMOD64, zero divisor @unpriv:OK
#382     verifier_sdiv:OK
Summary: 5/163 PASSED, 0 SKIPPED, 0 FAILED

As the selftests don't compile for 32-bit architectures without
modifications due to long being 32-bit,
I have added new tests to lib/test_bpf.c for cpuv4 insns, all are passing:

test_bpf: Summary: 1052 PASSED, 0 FAILED, [891/1040 JIT'ed]
test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED

[1] https://lore.kernel.org/all/mb61p5y4u3ptd.fsf@amazon.com/

Puranjay Mohan (9):
  arm32, bpf: add support for 32-bit offset jmp instruction
  arm32, bpf: add support for sign-extension load instruction
  arm32, bpf: add support for sign-extension mov instruction
  arm32, bpf: add support for unconditional bswap instruction
  arm32, bpf: add support for 32-bit signed division
  arm32, bpf: add support for 64 bit division instruction
  selftest, bpf: enable cpu v4 tests for arm32
  bpf/tests: add tests for cpuv4 instructions
  MAINTAINERS: Add myself for ARM32 BPF JIT maintainer.

 MAINTAINERS                                   |   5 +-
 arch/arm/net/bpf_jit_32.c                     | 280 ++++++++++++-
 arch/arm/net/bpf_jit_32.h                     |   4 +
 include/linux/filter.h                        |  50 ++-
 lib/test_bpf.c                                | 371 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_bswap.c      |   3 +-
 .../selftests/bpf/progs/verifier_gotol.c      |   3 +-
 .../selftests/bpf/progs/verifier_ldsx.c       |   3 +-
 .../selftests/bpf/progs/verifier_movsx.c      |   3 +-
 .../selftests/bpf/progs/verifier_sdiv.c       |   3 +-
 10 files changed, 694 insertions(+), 31 deletions(-)

-- 
2.39.2

