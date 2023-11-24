Return-Path: <linux-kselftest+bounces-553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648557F7802
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 16:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EDFC281DCB
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 15:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52673173B;
	Fri, 24 Nov 2023 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="XFIDj+F9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230CB12B
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Nov 2023 07:43:44 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cf7a8ab047so15735835ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Nov 2023 07:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700840623; x=1701445423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ccxLVdh5QHe0sHWS5YZYhy7xD8GTlMefO9eHp9CVDBo=;
        b=XFIDj+F9FsiLJiLNr5eOQWe8IDC/9hIiGwzMNGJJbzAsT2hzTMoaFHlHlGwHuGTsgP
         t+QussgiTl88n7KD58P25qu2STL2i875M/YIaDTHeStHansob13/VFiwPQ3mUViqXONg
         4Sw4SmRhtbqhWEky9IV37z3Vh42QkMWe6a0fbjmNuqPHZIKwPVd9y8j69GOdNA5/sFW1
         6fW7PG22ak3BmP4/IKvlFcdfGwjgvfk4JtcTwBLZ20eqDGAhV/pss7kniHaWXqpRnsl5
         uNaNMRmlHG4FuVC3EFyW6ENyDXV2KS/YOZkAazBYhmXzPylbbYkGoW/qRzOBWN9uz2O2
         m2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700840623; x=1701445423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccxLVdh5QHe0sHWS5YZYhy7xD8GTlMefO9eHp9CVDBo=;
        b=fViABh7FT7Wk/hXYGLGl/wODHWQmGJsM7qOBM+iN4Nda/atbtUgN/d2qRcA8f8HM+l
         /BKEDRNPy7GJr+B39eNYlggXrYSZOoAdwXO9Unm81Rq542B1TKdAjJj+Pw+Vujo8byvm
         6NV74/7KWrC7XAcDY948PrXKr8Efi5J7fBF4JMgA+oGfV63yxrExexQ+rGZgFNgNyMPN
         EyyqErTKH5/mwMto4n5PeAE2UMIUjyJ8SndgEyF0O6uhG3g29lqYlEX/9LjXrjm4mEhw
         EE/GNjDeLQWpty9wJU5kxdJg/7nh2noibclqldmP3WEcfjXViKki2G7HSA40WT4cGvap
         lCKw==
X-Gm-Message-State: AOJu0YxVAYHoN3Rbxk9+CKY3Pa9acIgz5NRv2Urmfcua37O5b+YtKOxK
	mtzoeLssZmcLki8ZbswKUT3AcA==
X-Google-Smtp-Source: AGHT+IH+F0/Tog/V3FPqwi/5b1xKQK3dDLRA2Wcasoy71mHr8RXKzKbvMnbhRmUo3wvfIHhrPbPX7g==
X-Received: by 2002:a17:902:c945:b0:1cf:a2aa:2360 with SMTP id i5-20020a170902c94500b001cfa2aa2360mr2442643pla.28.1700840623514;
        Fri, 24 Nov 2023 07:43:43 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902740600b001cf9eac2d3asm1919743pll.118.2023.11.24.07.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 07:43:43 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 0/5] selftests: tc-testing: updates and cleanups for tdc
Date: Fri, 24 Nov 2023 12:42:43 -0300
Message-Id: <20231124154248.315470-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address the recommendations from the previous series and cleanup some
leftovers.

Pedro Tammela (5):
  selftests: tc-testing: remove buildebpf plugin
  selftests: tc-testing: remove unnecessary time.sleep
  selftests: tc-testing: prefix iproute2 functions with "ipr2"
  selftests: tc-testing: cleanup on Ctrl-C
  selftests: tc-testing: remove unused import

 tools/testing/selftests/tc-testing/Makefile   |  29 +-------
 tools/testing/selftests/tc-testing/README     |   2 -
 .../testing/selftests/tc-testing/action-ebpf  | Bin 0 -> 856 bytes
 .../tc-testing/plugin-lib/buildebpfPlugin.py  |  67 ------------------
 .../tc-testing/plugin-lib/nsPlugin.py         |  20 +++---
 .../tc-testing/tc-tests/actions/bpf.json      |  14 ++--
 .../tc-testing/tc-tests/filters/bpf.json      |  10 ++-
 tools/testing/selftests/tc-testing/tdc.py     |  11 ++-
 tools/testing/selftests/tc-testing/tdc.sh     |   2 +-
 9 files changed, 25 insertions(+), 130 deletions(-)
 create mode 100644 tools/testing/selftests/tc-testing/action-ebpf
 delete mode 100644 tools/testing/selftests/tc-testing/plugin-lib/buildebpfPlugin.py

-- 
2.40.1


