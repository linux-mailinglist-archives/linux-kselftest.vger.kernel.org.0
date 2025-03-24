Return-Path: <linux-kselftest+bounces-29719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF230A6E6D7
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 23:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779EE1895146
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 22:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F011F03CE;
	Mon, 24 Mar 2025 22:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edkYlLum"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A957B1F03CF;
	Mon, 24 Mar 2025 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856649; cv=none; b=cf41I4DxkkVdQnBKwxOmmM05s6Ift/AmBb9buRyS57InbA/4govhvO2mpn9BGSu6T2ZC2FHewTAb7sggJSRU1Pz6vu1dImsGKa7Ym9N5huJYVBAvqAsNYx0nJqFgFUfY1GY5kxb5D7GjyYdR9NCiYDo1DAYraBFoUAFa7loiUgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856649; c=relaxed/simple;
	bh=o7U1ak0pbxpmtyG7WVTSuyEXJoAeywYrtzKL58MB95A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UmK6AzsHRR1nc0rbdB0+EeNhXPu+EBvFYRcz+Bb0iMi735mg6hTjXd38sEYmpcxB9kYSDy2IPVrYMhiAeh8H8evX0L48LD2yv+CpUHK1pA8bTM4+w4Jtx8sZ1rm6ls+0wW39wwhr8UVaSIOT5KJg0RBJbTI2y+dLdXj6EFGPS80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edkYlLum; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22401f4d35aso102666075ad.2;
        Mon, 24 Mar 2025 15:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742856646; x=1743461446; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=THL9SM9CIr/1OQHco1zss57OFJFzB7xQNy6a4lv9zYk=;
        b=edkYlLumDV6dT6CWC2CjLzanuBflBLko4CPENxIL8PFBsRUj0uBtgKxpsHUA5aX7w4
         XHY6ywYD0y6tZFC9gldQcpL7PMxV+wfdYug+W2QlbjWksm71MMWVE6OT/7LeLNjwxgRx
         gEIm+caQkywvcRds7NVmOU7NMnCK53cLPPbpKaK7lQIXycdPYYbt+VYGvqNt3aWMYgQH
         aQ4+GTBZYGs5s9ZTuI/Av5FF/99GwwBn4Luxch2dgb5Ah04rEZX9moRdR6MS6heqxuRk
         ByU34XoexMV4yLDpvT8sdWHKlwP8Y3cN+k42keW6uqQuQWB0u+9fMG1vyUbLg6it5oBf
         zrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742856646; x=1743461446;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THL9SM9CIr/1OQHco1zss57OFJFzB7xQNy6a4lv9zYk=;
        b=VxE24NWKlic9qreNmB6qOEQ+An1KmwpI7fR9Na2q8rCWo/VrzfqZ2quhiMK5uHhqD7
         1GuDWrdtURGilwKUYcGECplI6fg3n7+RM/nOFE1Pgkwtu89bqj8XwzqdUCvltBiyKyAr
         IwJUoIMxVSD7TtW9asEJ1UHOdjayVuj9bbGZr96fU/m4AFe9Ue4kUzDgJA2hGpr/Yc+f
         4L/fMypROW/RI9dMFvxGTYEeF4/8rOh56aOBF8pCYV+mYgafmLq89aXAmz/J6j/OMC46
         aTS96B+GNCPZ2CmH18ps2uz0rU0ClX2H/uda7bXBY9XYVbudKWPE3K7CpFR6ykb5s1ai
         Zpog==
X-Forwarded-Encrypted: i=1; AJvYcCWEQxhoLyHt+QPjsyKHz1ykSguzAdUmw+DOzS00suywOxdmTuA3XMABi39idgVzBE0dSe9deTHRDGznA5U=@vger.kernel.org, AJvYcCWHJtm1gnLBooSAAeIGomp66xL0Bi4q0I5NApJtchpfeYIPU4MklaujGcvX/Acljj6h6tFHiz7Nbne5+5PaWBfL@vger.kernel.org
X-Gm-Message-State: AOJu0YxVICBnsRwMgH8c6zB7f0sv+LOHXon07AmQOKewW59nNXr8Ntzb
	rADMmjus4BEvTQSWBoA8J8OVaKRxDUBuk9URMaHoAKRttAhfsR2H
X-Gm-Gg: ASbGnctI7mbi/XbK3LGjp7v8oJpE7yYE/sTSa4Vebu0SV2IoRy9u3QqmVT0KyIdMiDP
	RIg4a9MMX7myG9WkoPZPauxfKHpBTVKG2fd5AceuA0IEOJfR8lmj77vmR5osFPGNlMyuWkCd6du
	jf/ptxxYi0rFlH9y+Atlg0k7tYw7jqC5vDs/7NZLrO01fmjD+3qK1eyEKo+inSURogTWWmlrkxL
	Sd9OQ6CvufhcuRTGS15b4baG5UXjLZpocd7wUubZIVwmiXiD9JFNv9EXk7zgFZllGAIdFG/RlUz
	d9m3lizgAgoiMzpbTYogA6HycjcGxguM/XdZBOyMTr30XXki3JNk
X-Google-Smtp-Source: AGHT+IHUo+DB4F17j5XAlZKBycfMiHvGffi6iaXR4383DJgZLN80WWzx5mPBnHTVQsFvuKEdPw4iGg==
X-Received: by 2002:a17:902:dad0:b0:224:1d1c:8837 with SMTP id d9443c01a7336-22780d7ea65mr230887635ad.19.1742856645640;
        Mon, 24 Mar 2025 15:50:45 -0700 (PDT)
Received: from fedora.local ([2804:d57:4e50:a700:f33d:65d1:e22e:109b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f5b7823sm8801477a91.10.2025.03.24.15.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:50:45 -0700 (PDT)
From: Filipe Xavier <felipeaggger@gmail.com>
Subject: [PATCH v3 0/2] selftests: livepatch: test if ftrace can trace a
 livepatched function
Date: Mon, 24 Mar 2025 19:50:17 -0300
Message-Id: <20250324-ftrace-sftest-livepatch-v3-0-d9d7cc386c75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKrh4WcC/4XNTQ7CIBCG4as0rMUMYFvrynsYFzgMLUn/AoRom
 t5d2lU3xuX7JfPMwgJ5R4HdioV5Si64acyhTgXDTo8tcWdyMwmyBAUVt9FrJB5spBB57xLNOmL
 HKzCNwUstpSpZvp49Wffe5cczd+dCnPxnf5TEtv43k+DAdWWFsaiARH1vB+36M04D28wkD464/
 nZkdirAF2jdlIj66Kzr+gVMG4N6BgEAAA==
X-Change-ID: 20250306-ftrace-sftest-livepatch-60d9dc472235
To: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, felipe_life@live.com, 
 Filipe Xavier <felipeaggger@gmail.com>
X-Mailer: b4 0.14.2

This patchset add ftrace helpers functions and
add a new test makes sure that ftrace can trace
a function that was introduced by a livepatch.

Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
Suggested-by: Marcos Paulo de Souza <mpdesouza@suse.com>
Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
---
Changes in v3:
- functions.sh: fixed sed to remove warning from shellcheck and add grep -Fw params.
- test-ftrace.sh: change constant to use common SYSFS_KLP_DIR.
- Link to v2: https://lore.kernel.org/r/20250318-ftrace-sftest-livepatch-v2-0-60cb0aa95cca@gmail.com

Changes in v2:
- functions.sh: change check traced function to accept a list of functions.
- Link to v1: https://lore.kernel.org/r/20250306-ftrace-sftest-livepatch-v1-0-a6f1dfc30e17@gmail.com

---
Filipe Xavier (2):
      selftests: livepatch: add new ftrace helpers functions
      selftests: livepatch: test if ftrace can trace a livepatched function

 tools/testing/selftests/livepatch/functions.sh   | 49 ++++++++++++++++++++++++
 tools/testing/selftests/livepatch/test-ftrace.sh | 34 ++++++++++++++++
 2 files changed, 83 insertions(+)
---
base-commit: 848e076317446f9c663771ddec142d7c2eb4cb43
change-id: 20250306-ftrace-sftest-livepatch-60d9dc472235

Best regards,
-- 
Filipe Xavier <felipeaggger@gmail.com>


