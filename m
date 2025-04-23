Return-Path: <linux-kselftest+bounces-31396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FA1A98962
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 14:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480DD189A369
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 12:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1A126FA54;
	Wed, 23 Apr 2025 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpkOLn9f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2A7215795;
	Wed, 23 Apr 2025 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410461; cv=none; b=ooJrqd+45lPDtAY9hYkpwLDdRSwNy/cSrWwfL8zV9nOMb+0aXOrWlJf0TzA6yUFBguKRybqVR6ry+f5W08OrBTKsXQL1bviZCLISI0TLwSlNCBAEk36ZbpRfXZDnQT7L1BezRfPRjVoyVtmGsn+4jdkYAmbodzOENYwh66YSmzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410461; c=relaxed/simple;
	bh=MaeSoSWlAm4xCtD8eh/EXsSuw6MtRPVfsDzpLs0HcTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s9p0E4vH3zsxphm+bHZ6B2CT2nzhY6saqrfJvS2MoO+p3OH0/ELlIaa6PYGcS9Ta8XyfW7uji1McBBvez9HTu8yf4tibmUWgqOuMV6LVVmRzA0zNvyFOIts9gdP8cofX05UiVGE9y25alc42B9I+vhArrpCqtNFCdU4tSRfy0Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpkOLn9f; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2295d78b433so74060455ad.2;
        Wed, 23 Apr 2025 05:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745410459; x=1746015259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/xp7lM7Rh3BsiOx64d/oS0aSVgZov84XaA8u+TBgH7s=;
        b=hpkOLn9fm0E6tSZ1EcPRwL9oXCk+B1Kw7QWoWd/4k43bUmkNJ7uC4S0A8ILORTJ9b/
         wBXMLW60O1eau7KW60XcnqqJhyeudOv91vd14ANMFP0e8MNMMn/WkLc34V8GtjOJjoT9
         dS6l4t7wti+y7r1PkvJyErOPsh2E8rfY/kvoEeE+slWMAwIjWzuMCWC0oMJgv2dR4Oyd
         ko++3rdOWwukpONie6lYSKxzGFF0eTm2byNWDBLA/Png20DeVpdWLik+pj6XnanNK0zm
         Mn14Kg61hOD5vc7CeNRYacdR8DOX9I22Ld7eCr/7Xp8Ruo/sF2Oc8mtC9cB9FG2tSNCZ
         MlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745410459; x=1746015259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xp7lM7Rh3BsiOx64d/oS0aSVgZov84XaA8u+TBgH7s=;
        b=OiWPclw3ztrEa2Y/oA6c+Ch8ctMeREtfkFBCUUrRhmL2wjt7WyEOK//39/umCbh66I
         qggH3E2IG/rds6qMGvrMozSNbF8NZKWh2ApcJDllFpXdAd1z150F5oR6k+Eb9ZTBOqV7
         FA+XdusFqZ8cYGsHjvrENAN4nzVj0cTWbK/hk0qGI/tinfaIOr3iOVd3wmfJcYfCOUKl
         30aIO+qWpgdURNVGclEOQsSd97/8iMOpfdo0izPLeLqFPjhoZoyybNng+C52wrTNwUfm
         AIT3zf01vJ16mbwAHDJQ3mjnQQX8zVPm+FIHjcetoZ2+zYFE40fkJefg8SkrxV+kKvF0
         is9A==
X-Forwarded-Encrypted: i=1; AJvYcCV3dSrR9Lky/KgR0Nx8O4KS8VEtyWERpHwuG5UsqlMCyzI1LFnKB23eIKs6wiLdvJEImAjYfChRdc20v34=@vger.kernel.org, AJvYcCVPLMuqGLEp+75mqE0JsVFMh8hOZYczujrb50ZEitX47a/Jcuvo6eIZTJIUSpNeiPOa6gL10hQkWpsPUyOHgDAA@vger.kernel.org, AJvYcCVq/hzfTtWM0wfQ3qMZYRxCE5PK3k0jzNtIiqOdcdhETKAgKfevSwHdKzvkGsrDHd448xkyphd9@vger.kernel.org
X-Gm-Message-State: AOJu0YxRUvihpnNfdFS8uPd50+ev97nrABfoFG3t67ZBxkHzUd/SxiH7
	Jmi/W/+4CWGbso4TP6F7Nn9x9C5ErH/0EotlCLC7h+m9qfJ9kyVu
X-Gm-Gg: ASbGncsBKBHP80vVTp7tHssjwtYGHsHW/KFRZW34BnclZkWIBW6Sh1H12xizcsDY90/
	+LjA+KoPuZzbtwKaTdkSxL+ze2DW/z3lyu1l2BNC0YMbfDnLRlobX1qTh0J8Q9VTqgp9p2varm8
	mvkrUf9YNfieqdVF3TCdDQki4GI/BNOPBPNk6uIcD+4rrkscYb/OLl8irGjuwN3fOmtmw7g0rv6
	3oytG91q1I7npOqsxcYMCdXjntyBr8YlVKhmj1HPQgQBGS0IXXggMkSp4jB5cdULGJFugfuANXC
	QZ+kSkfAEuQLR4GSK5qBob9OsyTjjtyAtjM6VwvYGyI=
X-Google-Smtp-Source: AGHT+IHDJ7LCyTaOCeEviSCl6yoxwE65PGOilNvCWQjjpo+schzqn24NE+OxFtHGzsDdduz16UD+6g==
X-Received: by 2002:a17:903:fad:b0:224:c47:cb7 with SMTP id d9443c01a7336-22c530b581fmr289428275ad.0.1745410458974;
        Wed, 23 Apr 2025 05:14:18 -0700 (PDT)
Received: from ubuntu2404.. ([122.231.145.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf5528sm102647295ad.100.2025.04.23.05.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 05:14:17 -0700 (PDT)
From: KaFai Wan <mannkafai@gmail.com>
To: alexei.starovoitov@gmail.com,
	martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	memxor@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon.hwang@linux.dev,
	KaFai Wan <mannkafai@gmail.com>
Subject: [PATCH bpf-next v4 0/2] bpf: Allow access to const void pointer arguments in tracing programs
Date: Wed, 23 Apr 2025 20:13:27 +0800
Message-ID: <20250423121329.3163461-1-mannkafai@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we try to access argument which is pointer to const void, it's an 
UNKNOWN type, verifier will fail to load.

Use is_void_or_int_ptr to check if type is void or int pointer. 
Add a selftest to check it.

---
KaFai Wan (2):
  bpf: Allow access to const void pointer arguments in tracing programs
  selftests/bpf: Add test to access const void pointer argument in
    tracing program

 kernel/bpf/btf.c                                    | 13 +++----------
 net/bpf/test_run.c                                  |  8 +++++++-
 .../selftests/bpf/progs/verifier_btf_ctx_access.c   | 12 ++++++++++++
 3 files changed, 22 insertions(+), 11 deletions(-)

Changelog:
v3->v4: Addressed comments from Alexei Starovoitov
- change SOB to match From email address
- add Acked-by from jirka
Details in here:
https://lore.kernel.org/all/20250417151548.1276279-1-kafai.wan@hotmail.com/

v2->v3: Addressed comments from jirka
- remove duplicate checks for void pointer
Details in here:
https://lore.kernel.org/bpf/20250416161756.1079178-1-kafai.wan@hotmail.com/

v1->v2: Addressed comments from jirka
- use btf_type_is_void to check if type is void
- merge is_void_ptr and is_int_ptr to is_void_or_int_ptr
- fix selftests
Details in here:
https://lore.kernel.org/all/20250412170626.3638516-1-kafai.wan@hotmail.com/

-- 
2.43.0


