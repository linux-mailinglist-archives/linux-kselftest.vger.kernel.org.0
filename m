Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D96D71F5D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2019 15:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfEONsQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 May 2019 09:48:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33539 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfEONsP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 May 2019 09:48:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id d9so2804866wrx.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 May 2019 06:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DgryeVXBfS0oVlWILr3leOrpFjnwkDVNHwaRTJYmSLs=;
        b=Wmz44KxNc+WRAG37tbtVeUY8uQiVejN1WhSs1iXgHDYxv4oCMYT+yjQ0veYGBot2ba
         yxeaLfF6beXeyGniY/YNQOUzQHVR2u0s9JyJ7nM+CFJhbe3RjRPe3YaJ1ahLsN/m6O/7
         mAtELVAbVymulWB8lnXEtF7Tbyq3yGIbhxozQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DgryeVXBfS0oVlWILr3leOrpFjnwkDVNHwaRTJYmSLs=;
        b=Wg6AOfRRsXuWY9gqh+4fAt1tEfo6LdcuIu9//Z5X2cUA8DhAlpxgtTkrItUFav+lEg
         gpq6m8WUHnraJuW/W7Et8iHJvYAQdB9npd1bMOJ3afqKoD/u38sU0/xN5dsnTwqtChpK
         Brr3A2naFqEIX37NZFBvxha1B/ZizIfid3bcKofJLQfflfLCPkbHcx4gf9PZcq6K+Xjq
         0fOa7UAeiBQjH7Cm3OLi6+1idXJaC2RC04MQVf2YvTCdKXBlpxOIOCiT0Csvx58joG5d
         v9fkss0MzOi9YJBhZ9CVgV3l+EOehdLS5g9xFd7qjtuOMxEhyQ+b2UAQI8yZtFd0bRgL
         GMYA==
X-Gm-Message-State: APjAAAWDSGiVvq3hu4Me2EZPHMdx+qBHHU++8gnBDMlwkq7uFd++keHG
        ah3szIIpkx/cdyj5QE7X71jSuQ==
X-Google-Smtp-Source: APXvYqxoKpq4i6hxR1Vd+uEIthTPeUr9Z2rxDVTBtNcWEq/8JUOsD/KwIJmcXYs0OmIhopWuSg9uyw==
X-Received: by 2002:adf:8385:: with SMTP id 5mr8392281wre.194.1557928093806;
        Wed, 15 May 2019 06:48:13 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aea35.dynamic.kabel-deutschland.de. [95.90.234.53])
        by smtp.gmail.com with ESMTPSA id v5sm4498506wra.83.2019.05.15.06.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 06:48:12 -0700 (PDT)
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
To:     bpf@vger.kernel.org
Cc:     iago@kinvolk.io, alban@kinvolk.io,
        Krzesimir Nowak <krzesimir@kinvolk.io>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Jiong Wang <jiong.wang@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf v1 0/3] Test the 32bit narrow reads
Date:   Wed, 15 May 2019 15:47:25 +0200
Message-Id: <20190515134731.12611-1-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These patches try to test the fix made in commit e2f7fc0ac695 ("bpf:
fix undefined behavior in narrow load handling"). The problem existed
in the generated BPF bytecode that was doing a 32bit narrow read of a
64bit field, so to test it the code would need to be executed.
Currently the only such field exists in BPF_PROG_TYPE_PERF_EVENT,
which is not supported by bpf_prog_test_run().

First commit adds the test, but since I can't run it, I'm not sure if
it is even valid (because endianness, for example). Second commit adds
a message to test_verifier when it couldn't run the program because of
lack permissions or program type being not supported. Third commit
fixes a possible problem with errno.

With these patches, I get the following output on my test:

/kernel/tools/testing/selftests/bpf$ sudo ./test_verifier 920 920
#920/p 32bit loads of a 64bit field (both least and most significant words) Did not run the program (not supported) OK
Summary: 1 PASSED, 0 SKIPPED, 0 FAILED

So it looks like I need to pick a different approach.

Krzesimir Nowak (3):
  selftests/bpf: Test correctness of narrow 32bit read on 64bit field
  selftests/bpf: Print a message when tester could not run a program
  selftests/bpf: Avoid a clobbering of errno

 tools/testing/selftests/bpf/test_verifier.c   | 19 +++++++++++++++----
 .../testing/selftests/bpf/verifier/var_off.c  | 15 +++++++++++++++
 2 files changed, 30 insertions(+), 4 deletions(-)

-- 
2.20.1

