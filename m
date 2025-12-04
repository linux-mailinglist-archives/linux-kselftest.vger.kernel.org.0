Return-Path: <linux-kselftest+bounces-46971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAA3CA2520
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 05:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88622303E3E5
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 04:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C712FD7A7;
	Thu,  4 Dec 2025 04:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgarnY1E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A062D4B71
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 04:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764822889; cv=none; b=nTdGNi8TGprMyuxsWwOWo4PpP2ldNlSajRBA9xOa55q7o4FP7+03QK2vF4e6bBFqswtuOS9Km/NncUuHKa9cJer+fuqtNfyGuivfkO+o6yAP7AuK5G63t+mk3Dzji5Ptxnlva373cK7PTtgvYkDTwfUpdmX5F6Gduoex69axeVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764822889; c=relaxed/simple;
	bh=GgCOziep81e/EKJzhQH5y0QjEZ56iWmp92jKRaM/sWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZ/RxTihHa70rXHvq2GdcWXy1VrovGUgjKPD1cYKmqW/LiRxTFfbdJGPaKEOzA45WXKMc4SLQH478f03YxR45BOT/T9ryk9+FZnjmCdslsgx+b9gCwEN+Cg9ev4uGs/XywI1fWDIYKDEEhUalVmT4xsYC27udefJnn8aM8s27BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgarnY1E; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-640f88b873bso415484d50.3
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Dec 2025 20:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764822886; x=1765427686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOhogF/bEKUSSSKE3BIN5Xdxnrm5TbeswyD2/DYOGps=;
        b=OgarnY1E7Gkjw/DevGDJBFY0b8v2+sb6MpJxurlwKQgaJGm7hQqQSZzeFiQT+/ysq/
         8m2dbJcKT4kXSHtXSXXSwmuitQuoIP957gD6fQT66xxlxaJ0/lwcnKaT/VU85TiaVNqs
         kffs+HgDrTGjeAEsRb83HDRkMtoXeZbfSlbhNXY+hpGNwAJTGXbQIFgJZPMOQWqTGG9E
         jjhiAY3KiDVr3YyDXKwKMMlA4SVbRNvC/MQjliUnstYCtSy2dAV9bMEUa6MR+AqGW4XJ
         NeTSNcXqijTCn1AZ1ak8FiT+dhg4dZ1M5oitgNZGdt0X6/EliVPeEPLoQLv8kTkLzXyM
         XIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764822886; x=1765427686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nOhogF/bEKUSSSKE3BIN5Xdxnrm5TbeswyD2/DYOGps=;
        b=Vh4lShJiaXDH8L4Ju8y8qFWveo4I0UDVgpFLQU4sQ4d8i5+qyjvCWBCQ+mYT/Ergjr
         iqR2TfEE5nZdf9k5QOw8H7wAfTVqU0fTT6EB0bk76krlWcbE5z5mG3AsQD460oHU2zci
         cK3wNcmpnW4dSXLXTjDfUT318eONQvV8+xiuyai9tSsX2yBW6fy+7vffxFCGeG8JeS/v
         IqT+rdedRw/MfGOCqlNbSBeXjCq0UBC8jqikjq5iNTUp5i4tnlImr5tddvuO7GKYS9JG
         LHcM3PQ5rxG5B7kWg/wPetFMfhDKaeM4v9y1XUwBIt8V6EduIzanCHij+X9DNWs4+XO4
         psCg==
X-Forwarded-Encrypted: i=1; AJvYcCUsmmJvnMBlZ9oPzisQ6uOGvB5G/pTFqmKnFL9jbzuBLK7OSjRqjXpvh/kzdeVqoa6SEUTKnZW2/q9Ax5fivh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfxxw3hgmksETwToenJ9iA6poUahu5cG4BPi2pQd97T8HUZBsD
	yo7amvDjaS7CKFjcRoJgvXqUxEAjVQH4Fe16QuzLS5g+hizocmIoYFft
X-Gm-Gg: ASbGncspbj89HgP3blhrRnA/Yi/p9LkIAlJZICnWu6p8utq04Op/Iea1ZSb7KW3aHXj
	CDzTgNONWrEH8YfeVBhFj1g31Sd9AB1XzoG8qaEBSCwbDCBAlahNgai5kHAKRgmuLp2JFw5uSni
	7IW0u6WvOyfZnir6UY7lZWThtJNOkQt8/NbFNDbLm3FFdV3UJocWeDv8AZ20MND8R+fSBQaAfjE
	cZL48Ivd2aHS9+zFrb+DxfhukWVsk0vwDIO0sl5faKmNqw9Vf5ngvUwQBPyeo30zvQe+qWdW6e0
	/Um9PiII4kWY4TQcBWr13shfWg4/0Vw2VdthCpTfN6UBwSSLAyZA0BU7pfgQtvadsXlapRy5Etx
	JTuuMBdtKQ+8KhxUUg8rGiZ0feDAbh5812AScsv5Cx9+Z1Tz4dROVCmIp/0CVaUFxIxOGmcYQDi
	4B+drqA7Kor8ZFztMxYWrp3ZN13zVnvwqeKqHSVi2XEMeCapKWXkY=
X-Google-Smtp-Source: AGHT+IEHsk9cvyWivHQ/qdx/M0oPC+5Tq8/rSqUEJ8fSJ/n8FLJKr7HCddCe5NH32qGcbWy5RlaPRA==
X-Received: by 2002:a05:690e:134a:b0:643:ab7e:8dd0 with SMTP id 956f58d0204a3-644370659camr4211118d50.61.1764822886420;
        Wed, 03 Dec 2025 20:34:46 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6443f2abde8sm264191d50.3.2025.12.03.20.34.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Dec 2025 20:34:46 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dxu@dxuuu.xyz,
	eddyz87@gmail.com,
	electronlsr@gmail.com,
	ftyg@live.com,
	gplhust955@gmail.com,
	haoluo@google.com,
	haoran.ni.cs@gmail.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mattbobrowski@google.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	sdf@fomichev.me,
	shuah@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: fix and consolidate d_path LSM regression test
Date: Thu,  4 Dec 2025 12:34:22 +0800
Message-ID: <20251204043424.7512-1-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAPhsuW6hmKjJF5gYvp=9Jue2N6oW8-Mj-LdFbGnQVwW1bTB=qg@mail.gmail.com>
References: <CAPhsuW6hmKjJF5gYvp=9Jue2N6oW8-Mj-LdFbGnQVwW1bTB=qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Song,

Thanks for the review.

> I don't get why we add this selftest here. It doesn't appear to be related to
> patch 1/2.

The regression that patch 1/2 fixes was originally hit by an LSM program
calling bpf_d_path() from the bprm_check_security hook. The new subtest is a
minimal reproducer for that scenario: without patch 1/2 the string comparison
never matches due to verifier's faulty optimization, and with patch 1/2 it 
behaves correctly.

> The paragraph above is not really necessary. Just curious, did some AI
> write it?

The paragraph was indeed generated with the help of an AI assistant, and I didn’t 
trim it down enough. I’ll drop it and keep the changelog focused and brief in v4.

> This {} block is not necessary.

I’ll remove that extra block in v4.

Thanks again for the feedback.

Best regards,
Shuran Liu

