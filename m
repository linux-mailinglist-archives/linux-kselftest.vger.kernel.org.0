Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4435679309E
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 23:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbjIEVGc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 17:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbjIEVG3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 17:06:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616281B7;
        Tue,  5 Sep 2023 14:06:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31768ce2e81so2430806f8f.1;
        Tue, 05 Sep 2023 14:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693947983; x=1694552783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sSNRKoiYVqeI+6LdDm1Zmc3zvMitEmgpQMdZQfaG9dI=;
        b=RUEmmqeNAnCqR4nLkZ7vBjamqsFQBBEP91zFHHYLAsHxA3Ibpr4PXvZM/qgz9DkxT+
         yk+M7to7B3tUbdc2X1bE9A6AMp4AAm02yiUGjuZLV6r954vtI+iGgWQFz2WyXd2XTubt
         DL9cIukL9EEWApe2rFfbq7hpSX2E5zurdZ8mLEcB0eTXp4kxfN1Q1BrxUCJLCWpZIeVw
         /FLrBdcj/rkVd1vKSH55iNeKhW8ry9q6uGHoFl50gtIwYDgd7W4ftMO5xCRnuplloNty
         Uz6t15Ex8ElNu+CFp8STQFqGO5QcFuZ8dvw6SZAwNp7tBQqdWQw7UWIchCO6YyCTQw/v
         bovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693947983; x=1694552783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSNRKoiYVqeI+6LdDm1Zmc3zvMitEmgpQMdZQfaG9dI=;
        b=FYe0FkTcaxtUl2up480L25vsd1DwPWF20cNeG0fkoclhF5Z/N8pAzHttw5mPZfUd/H
         AK8hYQyN/GTgcEUuB0OH999fwf2hwiCsPBWVXGSQqdu3oALGVm9LeKDTNXleoqL8hGRw
         R1e/gBN4bOKDbYSYsgTtFY0d9SmLDGYSUhc8b6QS4FcNkzxFyzyVmNCr6qgUj5nPi7HQ
         Av6ys39lTu5BtNq08JnHUMd185lX9hKJm2HUvK4hSTaWV8aEDL35M3iwwS3aZzYkMML2
         Ic/4r3yo3UigKiG+U7nmUmUmFlygkzGJ/rV0JDiD3fURxwqEatsb7cjekqJnte7s5qY3
         yesQ==
X-Gm-Message-State: AOJu0Yz82JGO1aZE5eldQ6JeQhZLayP3/VIfCxJ6sWGEON17jQ2f6gQ/
        H0WRbCPaBZJ3wCsMUm+zZqM=
X-Google-Smtp-Source: AGHT+IGU4HQTEq5maFXCNNmFCbt+bhir34vLzDYorhEZ5iqcWuFqf88Am1txE08GDK1HqqFnKMLgrQ==
X-Received: by 2002:adf:e647:0:b0:317:6348:8a9d with SMTP id b7-20020adfe647000000b0031763488a9dmr626747wrn.66.1693947982401;
        Tue, 05 Sep 2023 14:06:22 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d5012000000b00317b063590fsm18427672wrt.55.2023.09.05.14.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 14:06:22 -0700 (PDT)
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
Subject: [PATCH bpf-next 0/8] arm32, bpf: add support for cpuv4 insns
Date:   Tue,  5 Sep 2023 21:06:13 +0000
Message-Id: <20230905210621.1711859-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the support for cpuv4 instructions for ARM32 BPF JIT. 64-bit division
was not supported earlier so this series adds 64-bit DIV, SDIV, MOD, SMOD
instructions.

This series needs any one of the patches from [1] to support ldsx.

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
modifications I have added new tests to lib/test_bpf.c for cpuv4 insns:

test_bpf: Summary: 1052 PASSED, 0 FAILED, [891/1040 JIT'ed]
test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED

[1] https://lore.kernel.org/all/mb61p5y4u3ptd.fsf@amazon.com/

Puranjay Mohan (8):
  arm32, bpf: add support for 32-bit offset jmp instruction
  arm32, bpf: add support for sign-extension load instruction
  arm32, bpf: add support for sign-extension mov instruction
  arm32, bpf: add support for unconditional bswap instruction
  arm32, bpf: add support for 32-bit signed division
  arm32, bpf: add support for 64 bit division instruction
  selftest, bpf: enable cpu v4 tests for arm32
  bpf/tests: add tests for cpuv4 instructions

 arch/arm/net/bpf_jit_32.c                     | 250 +++++++++++-
 arch/arm/net/bpf_jit_32.h                     |   4 +
 include/linux/filter.h                        |  50 ++-
 lib/test_bpf.c                                | 371 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_bswap.c      |   3 +-
 .../selftests/bpf/progs/verifier_gotol.c      |   3 +-
 .../selftests/bpf/progs/verifier_ldsx.c       |   3 +-
 .../selftests/bpf/progs/verifier_movsx.c      |   3 +-
 .../selftests/bpf/progs/verifier_sdiv.c       |   3 +-
 9 files changed, 665 insertions(+), 25 deletions(-)

-- 
2.39.2

