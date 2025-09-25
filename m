Return-Path: <linux-kselftest+bounces-42274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C36B9DE46
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 09:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033384281F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 07:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B0824167A;
	Thu, 25 Sep 2025 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WG3KMu8/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42451A4F12
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758786395; cv=none; b=SGWvWNxThh0sENuQLA+gPLrxllBOWVdzu/F5vRwRbHlKiUe9vBdPzy2kwptAknpUqi99Nc9i9ht3X0js+X4QPG0q4Ot06GF0YbciozaadYz+jVVjLonZiVzcIwe4QYfOV2gsvujAVkLfJWdZ1+j/TSTBcjWcP2R26C/9tgFdDcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758786395; c=relaxed/simple;
	bh=jtdhp8/eWxBbnFoUTD5zhB3JSfjAFt5l4grv877/WGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tijbdb/D9HOjPkXmMV2gQAvlmpFs4XnZWFMSwr4Zo/1xxz6iPv0xPbGyrSIJxKbwLwZaibq6Kfsc/irr3QGVz+Ma9Xz8ifqsKpt9hqZE/zP4EhSFDRzYpfvUi5OcHRPbr1odcbQ3Wna6GFtDIaeaOumXJvaHfOtYbuk/myGDEvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WG3KMu8/; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso734062a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 00:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758786392; x=1759391192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtdhp8/eWxBbnFoUTD5zhB3JSfjAFt5l4grv877/WGA=;
        b=WG3KMu8/2qZJShFG8hz9XrX7A9NvJmEplDYvLmhF361coxYx3d6gGMXdnUz4CLW967
         FnSH5KC7F3rh21QF8fqPHU9ikQUafZGEKCsqCCqNIOBDjuVp9aPeTmvzXbooH9OyrCpp
         27KbO/YdG6ZdWtYUfxYdZGe69ae+kymxk0OH64ef+YiFlXJFRjHy6KucAUSMo0m3Q8xP
         XBzhR+S6b4k3JMvf3gDAX5SZ9MqyeiR8GPZRDRLPo3AGPYYrSPC8gNv5uZOg4/9Rl8YP
         FDrO5yW+9NR1t+3gv/B0X5kII7asKWaaa0asRrzgYJgHq2ezJql1ZjNCXGW/h8OQK+U3
         TDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758786392; x=1759391192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtdhp8/eWxBbnFoUTD5zhB3JSfjAFt5l4grv877/WGA=;
        b=UAAp4eTEw/ki63kAWV82gLEkTmdURRInSWDg89UaQ6GFbctLh8UqmwsvwZCGEK7F7G
         1EWc7PsE3hquyafqSF0ABpTZCX77Rdl50t1E3zguk8eLRfRZQYDiR+JtbPzekTLeF1rV
         VVZ+Nygag/Ixz4i+azEfv29FP8OlCaHJmA58n/wULS/H/dc6/lFPDcCLgJLxYYXVqTfv
         6JpqOavl16Ja4VevI8JuspzXTIpbZPxY8MOpMhajyCnjf0/XhDof47WBRr3atPNVehYA
         ClsqYqDSSQ0Zb6auXLOKrzB5lVWxM/AK1C3yFxkUR/B3THI5QDGahNAdmZ36PTG2roxh
         XCSw==
X-Forwarded-Encrypted: i=1; AJvYcCUdEtzzKnqIX0xOgx2R8AojgOcLHTPhCOa0bl6wuKELe92qTdsuBuYCthBSuVSZuJMWAsB9/c12tf6erX53d78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAYHVI0G89WrcnusF0n1V7xTYQjBGHZUCSKfZSoT4nZWeMMeSb
	k6QlGlrJIe4K1M22N4S+MwVhuyItMqQqwjcZLt2766t20OV3aiDSMUqz
X-Gm-Gg: ASbGncsM6wngJ8L5HXc2CvIet47wbEaM7eMKjC2D3gexozjNgiMannXGvDN//0dQrIP
	52vckhyJZ5Q4PAYhlAKYrKmZ1Jp7YeWBaOXZml70DzW5BguGkH4errTZdFq8iE9ROjwf9ij0DvP
	U8mbLZsu19nm3RlT7O+J6wGJY8vZlFL6rHLtw46IKW7qiegkwKqezS2MvR+kEbl4ZWE/nhqSnQf
	DzzRYKhaQu969IOcxhOxoqitSDU0sB5HhS2rAeByAHHlxvmIqFh9DSZp3TqCwKjFsUYqzAbSR7g
	IQblCx9WoeAab+mu3t8wq95U2dBo8wzfJNsXod+HoEJbFW6ANbl+038K37QeoFLdKxBosYw7uNp
	a9sIPQY2/nVr7NFvI15hvCTQM
X-Google-Smtp-Source: AGHT+IEgqMY9KuuP+oAMZMqc6Jdkr6xcn2BVicCSHUX4Ny0/XFHAn/j/jN3MLmWXNnOeMrfb2SGggg==
X-Received: by 2002:a17:90b:1808:b0:32d:4187:7bc8 with SMTP id 98e67ed59e1d1-3342a2b11acmr2858725a91.27.1758786391907;
        Thu, 25 Sep 2025 00:46:31 -0700 (PDT)
Received: from archlinux ([36.255.84.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be14666sm4753864a91.15.2025.09.25.00.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 00:46:31 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	madhurkumar004@gmail.com,
	shuah@kernel.org
Subject: Re: [PATCH 1/2] selftests/acct: add cleanup for leftover process_log binary
Date: Thu, 25 Sep 2025 13:16:23 +0530
Message-ID: <20250925074623.142164-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <d8df684e-0c09-44ea-87a4-cdbaf65ab0b8@linuxfoundation.org>
References: <d8df684e-0c09-44ea-87a4-cdbaf65ab0b8@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Madhur Kumar <madhurkumar004@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH 1/2] selftests/acct: add cleanup for leftover process_log binary
In-Reply-To: <d8df684e-0c09-44ea-87a4-cdbaf65ab0b8@linuxfoundation.org>

Hi Shuah,

Addition and deletion of the line happens due to
the newline at the end of file.
Code unchanged otherwise.

Regards,
Madhur Kumar

