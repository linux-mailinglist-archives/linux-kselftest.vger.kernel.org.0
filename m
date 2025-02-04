Return-Path: <linux-kselftest+bounces-25637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61224A26A11
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 03:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B66163779
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 02:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF819139CFF;
	Tue,  4 Feb 2025 02:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSHEjtc7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64470200CB;
	Tue,  4 Feb 2025 02:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738636796; cv=none; b=V7hiXR/zlE0lTF77Zi+Xk81C/tGuxBj5vfxMb5rV9wPBa1dcyyrW24ztj1KNeUX4eNXg42HMCgEWuCFYaRnWQ99FtUYWuJsZ6LDK3JeMpL0gQAh58TsLIJvLuNbaQFcvjX2l77iBf5Rq6g+Fe3TdOTuHdzUrq0d9FsSHB9SJyzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738636796; c=relaxed/simple;
	bh=AK1cYduMPBIrZeOqwGzmqxKSVySM2dTS6Bz0HGqdGrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=G5/l66fk9cswnfnnxvrJu7R5heYUFSpgLTtrC2yF4PDEHEwrCL7RjPgvKBWHomiVozwA1tB68GHgZc2eGX1QN4CTjmMAdF2/Qb5nKSJLsQ3m/MGhnsoELQLK8fVjW9j0nlMI24tOSAZuSPZF1H16zHCJxNGEcGX3wrUgKdPJoU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSHEjtc7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2164b1f05caso85482825ad.3;
        Mon, 03 Feb 2025 18:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738636794; x=1739241594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sOeyeiyoDv+MpAwFRpLwxUlyx27BX48gdMVE31rDb1U=;
        b=CSHEjtc7mwg8nERvsDGhRfi+lwz932aGwCaDVrBhi+Z+o76LCJg8v3m1P/53kKvhtr
         L8CFQsh285pvjDNtThfGhT62sCJ2CyKp+UouTwDWpP0OXNLQoooXQMRMlFbfe2xF5pVR
         kP5gjH4UzF49UQP9np7IBxk84PrkG+WLRWskS3oom9Us96nZvB+bMhkwP9B4waMfyf1a
         Uosb8X4y9lH6u21nAuqbRIWawjZff83Qm9LhY+v8cR2sBc3qHN4HOXezSLGuxcQLvFwQ
         DVFbovvUJfuEVkRCuqTgx9F8W8yfrp/bwST7F9k9Due/qJ76aO4EVMIf778YcDeHml3A
         jqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738636794; x=1739241594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sOeyeiyoDv+MpAwFRpLwxUlyx27BX48gdMVE31rDb1U=;
        b=eEYb80VWwLRx0+M0DabSDAY7Imy3IQAfCQkNgw/YXixqeVKTTiZQvHJ1n2aihT1vxp
         6FuX7iz7FwQBk4ZXL6kUdGJNOLPE0a81txFpLNgDKV+oW2AG9VhcKQJtukKX2lPpEYag
         mglNVcEYnYlS0F8qPvtlVUb1roTPq4A6mSnurcuG+iZQpiR+/KqivUfH0Tq/XZnmitoR
         zNSl27oqK0c/T4T2uKQJTasRMaCdZPe31EwOHEcqi0HA0cCJphqjTAxvnKthJtM+NEBE
         cwukWrzQslGcIm7u+/oMyr8JA1OAG8uQaxjXIuylTSGRbtn893ff5c7j7zgWg6hmChcW
         KngA==
X-Forwarded-Encrypted: i=1; AJvYcCVA6342RhStsAUZK+SUaLJ1hHWvn/cqwDYcHVf5T2m35RtQfACjSEWkGY4XEM1r/mdo+wFPShVTt/Tz+nlgRIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpjTNyQp3WjfJ2AF+xwI/upSRX+aILtnbwak3U3MVMeSVN6KT4
	DbxdK2u6XKmPpbq62QxrmN+yUwDjtxWOL/Kndiz/oKVE8QMnsGnP
X-Gm-Gg: ASbGncsTHuj4CS68Sg1DzwOPZzSw8EQbJJ/DK3IuWlBgK+myBC6Q3GHmmAXWGnYaJKI
	Jo5vIVktDlRqBNoPPvSsuSzoF3fivhAGXc79zDqXMTGthmfIRw/ilywLdOGUBKR4X3Vhd2DJDZM
	170l0xJXuL0zg6x4x8CJvHhrX7q8L1+LRAbjD71jOTaw8cF2EIuwbTCaR8YgqcPk/QkzZi9eweZ
	b8m7BVIvvzc5q/CxYxjUPOV1FZh6F1car3Cyitl73UuFnuSnDVOUIqN6QHZJUZTKia4M4EzJ4Pp
	uFSYrIfLWPj/s/601rJ/Zzo6UXyx/a0ucQnYUeRwqhNgTVn6wpPrfQ==
X-Google-Smtp-Source: AGHT+IFLXSVSXkbJBGLJsfYRsszEjqwmpgE8OWaJO+jSL9vTwc+lob7bA6ke5qv2kzl9mKiF0B5s8g==
X-Received: by 2002:a05:6a20:9152:b0:1d9:fbc:457c with SMTP id adf61e73a8af0-1ed7a6e0009mr46539272637.36.1738636794575;
        Mon, 03 Feb 2025 18:39:54 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba44fsm9660492b3a.100.2025.02.03.18.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 18:39:54 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v1 0/2] selftests: fix two small compilation errors
Date: Tue,  4 Feb 2025 10:39:44 +0800
Message-Id: <20250204023946.16031-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix them separately in each patch.

Jason Xing (2):
  bpf: changes_pkt_data: correct the 'main' error
  bpf: sockopt_sk: fix 'undeclared' definition error

 .../selftests/bpf/prog_tests/changes_pkt_data.c      | 12 ++++++------
 tools/testing/selftests/bpf/prog_tests/sockopt_sk.c  |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.43.5


