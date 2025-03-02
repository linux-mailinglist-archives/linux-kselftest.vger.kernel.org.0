Return-Path: <linux-kselftest+bounces-27984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC388A4B4C6
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 21:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7DED3AF031
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 20:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2EC1EC01C;
	Sun,  2 Mar 2025 20:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDdAb+he"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E465A169397;
	Sun,  2 Mar 2025 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740949158; cv=none; b=nPxZpNXJ3HOljCTCZvCvniO3ZkRWB+XWf52uXzt65Y8PuqR0Y/4KHfguXwhBSibNS3efRxALEemNGod6Wrozyh/xa4wamEp/XOBZE3EqeqM+hThK+mKNjDX3jv9fcI6RtpCEpITFQBDY5U2VUFat9rXz8N1IyOdKpL+yAtdm9TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740949158; c=relaxed/simple;
	bh=rP+alRinymgCxjKudWj/HY6iao/PpoZjg9vipcYUpXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qJ2scdXnAMgeIby9+bbOHgLN82PGw9CL9tpivcSB6j3GT0xOW7fvBecrAL6ptYL2ExcHEKdLTe95+qgkt8dB3lrRTiaKw+04LnYPxvpp7qkqdBKKsDhS3gbS2y8NfRh01f+6WqvpHFzIe0NYqCy/1CZplk7oiQf20BubuyYq1pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDdAb+he; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fe82414cf7so7394441a91.0;
        Sun, 02 Mar 2025 12:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740949156; x=1741553956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CstAINYAdh9SkRPuTu5l3jqM1YjiAYtnuWwBPbW1Me0=;
        b=SDdAb+heYLTyBhDmPoOGFRNDCWfzHFfEf13UCJYkpP6fNev9ZQlzCu9GvwhCMV8Z7o
         2ysPp9/hHhmsbeC7LqFCNQM9tJ/w1iGadWpL5zVOpX3Bb7jF2QFmSPcGsM6NjD96XFqE
         uCWAOaeHb/CJz4vMO3rXmUPNAD8A6kz3j6S8aujklB5ss0lhj/V8JIepGRA9XumFC6OX
         0RYrSKFHgqTJ/VVnqO0YSMPFmJ1BVm+4aQeB4FRTrDAcsBf+dHaNx1F/yuOKMZAe236X
         x4YacbbucL8rZTj/UK7WdiFDfBbCsF+hkxcD4h8B+0LMJ6fKqL3YmH52nqo4IgVi4lW9
         MyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740949156; x=1741553956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CstAINYAdh9SkRPuTu5l3jqM1YjiAYtnuWwBPbW1Me0=;
        b=tLgQuRSzJ31upBtF2Ktkwd36iuHxQusgCN8AlSVG6J1M0gPALtKi7cz4rjwUwiCoRU
         DVA7xE6PraUtHWh1lfCS4r7c4+1f/JHH29EjyxDY641B1bS//T+26Gcfobrxg8Dbfxu5
         v/ZoHeYofi1OAT2sl8e3RoJPhfhn4+XTh3yOOnnDtRVBwtMlNazwNpFO5j4YwiKYEcVk
         +sqvAIyYadpXzQTQEkc9+eDX/aFz66a/ZWPy8B+qyYwwzMReFlQeQiFbU7wfP1MLt9Q4
         tu1By6CbBkNYtSxGNsRVnTye1fBirolPtkfYjxY0KPy5i32kQb9loKljb/7gsBbrW+ZS
         VMtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+FVEq/XWMJfIonQ4RguAuxJ5En8YwYwhoQ/YxV2J0DJoR3gyfS2u+4ZnABSzXrWI65tAOmgNbmkSXq+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwslI7lkG7BEZWZi28F0NmwFhnzXn8b0ca+lyPIj4UMWwE7yyqA
	5/VZkPwoiO+UkgLrZwzDSzpddQWkjbGRDgQCy1YUvH/Yc2OFmQfg
X-Gm-Gg: ASbGncv0j0IaDMEkRDvbjC52l4fKHNPTmnG4myjz13Bb//b+bm/9Tck6fZ5RrNr7tZ0
	jrmLjPdf64sTk2EHnPmqjY2ORdvEOw06tOrKjehgVhLbhrVxSV5rsPP9K8SFAltMFAbMWokZQcW
	m3i9xonpyu8jcjg+9OMrLpuz8z4dP3p3OhpVv58rRXqH6iaUSPfGnxRS3mQV0Eff45F4tTh+BtL
	0jFBgqyyeYGeO3M5CpBJ/c58FDXaGCinaS0perdEfwUPyjdJnI5n9oeDeTfm9u1j4ge5yGipYwK
	xTLnM8OCVl8S4xEg/Mse4ARxIKOjdwsEnq4qoTfO0MMIX0DCfN3RoBggwsHwqjn1hpM=
X-Google-Smtp-Source: AGHT+IFmFpduAgf6WZEhvgUOaDiEB9rpG2pbLvcGn8o+vuTmgEuskufpEMp4Bx3Q6i/Ah9hYln7SDA==
X-Received: by 2002:a05:6a20:12c5:b0:1ee:d418:f764 with SMTP id adf61e73a8af0-1f2f4e01887mr19476003637.38.1740949156029;
        Sun, 02 Mar 2025 12:59:16 -0800 (PST)
Received: from fedora.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7dec3e05sm6827947a12.49.2025.03.02.12.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 12:59:15 -0800 (PST)
From: Siddharth Menon <simeddon@gmail.com>
To: shuah@kernel.org,
	brauner@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH 0/2] selftests/pidfd: Fix missing headers
Date: Mon,  3 Mar 2025 02:22:44 +0530
Message-ID: <20250302205859.14782-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix compilation errors caused by missing headers in the pidfd selftest.

The errors include:
pidfd_fdinfo_test.c:230:13: error: implicit declaration of function ‘mount’
pidfd_setns_test.c:172:54: error: implicit declaration of function ‘ioctl’

Siddharth Menon (2):
  selftests/pidfd: Fix missing header
  selftests/pidfd: Fix missing header

 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 1 +
 tools/testing/selftests/pidfd/pidfd_setns_test.c  | 1 +
 2 files changed, 2 insertions(+)

-- 
2.48.1


