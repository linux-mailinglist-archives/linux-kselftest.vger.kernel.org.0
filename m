Return-Path: <linux-kselftest+bounces-45062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FFDC3E851
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 06:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F237F188BBD5
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 05:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635B62D979F;
	Fri,  7 Nov 2025 05:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GjwGwyIt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CA22D0601
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 05:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762493406; cv=none; b=F3pIpOGmFta7zBBSJMbL4n5BkmOnNfiNLLqMGoWMZL5G6zrReV+QUlTH42DBH6au2nY/KIeMLEaZqR/ogSK68wjTymVf8ZbprIHbbv5m1L3tjWjUWeLPWv8e5IIUZLWUSJ95Pg4ZZ1CfFEc1FeYKgS8jFnGjIQVNw5vqv0XBM4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762493406; c=relaxed/simple;
	bh=GNIC6rgmBgBaS/nEumt2IhuduUmMu1+lZQVuuQDtb1E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C1ph2SLA34hZq+5XMs/031eXmTVlUcQ1qCIR9xKq80psREH5O881xLZt5rpiGmefH7iItouJ1ZVYyT4qpw192uHYcK6U7olrxodiZgW8N8HWihFwN8904f857JNHslqoyb4ieP+ojp3BVEx5eC84Otw3n8lEsYAG5r4SAAMRJ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GjwGwyIt; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-891504015e5so95735885a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 21:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762493403; x=1763098203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EaeKaOMtYstcTutB5sBdiY8lvk6UG68jVdp0csxEu3M=;
        b=GjwGwyIt0wwW3nEwzXvy2WUgtmxpOAllNNCzUvVRa7HaBauJtbOAO7XucpEwjkodJU
         FzfnBbKplLhxZGvkDda3XFa+2xuFaeN6w6dHyKPTnNttPobQf1w3SdnSOvXasoBb1cH7
         8/GUrmux0PlVYidJ1Tnt4gZ+ID73OqET7oRXSSg8UWwLmKQFzrRoPwL97/C8+dy+2sPQ
         SDWQEBmPmwwJSzfoaxh9CHh2/yKZ/2VAiY7AJXnmeWRsxqoX6FCZwWqWVamA1+2zCCTe
         5xfWvn0hh0+HihQ5Hh4R8lrVSRaBYt2Q8HQUabm9idmwivMOuoZQTCaMUhr7CcuON3RI
         S0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762493403; x=1763098203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EaeKaOMtYstcTutB5sBdiY8lvk6UG68jVdp0csxEu3M=;
        b=TBxfTfo7fmJjzXY8QmsCI0LxqdqAH0UcaWBGygwv2Al7QgT+gvZ6b/xMgYpPbkOz+B
         IzVqUbNH15Pb4DId0367of1C+GfJJi9nYVXqGNM8tmNV1eE3yxXOVH17NMuaXYxKx6tv
         Y5eSUd3V5lF31tjAXE9xr6xWF9TkbhrVCr2rNE8vAWOPjflWF5rhEvKkucrT/k3nEc+h
         YaOUNWmXvBn95hDNdVE8j7tXw1oIVToRtKQ8U5lYHwGdFRfodsj6Kwuj9ufyd8RDGX8J
         HeWOMDiYIYtj3sAfVLov/gGRZ/o1v8yiE3wW/RCDU2+SinWGERg2QaPMrHpcxv70DAa/
         PPyg==
X-Forwarded-Encrypted: i=1; AJvYcCW94j7JfG4KcibokkikC15gW5nRw1+m25Fl2k6CbB2nacsU2NlB86nHpDTTmera+ksila40PPuvp3jucD+cirw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAiYUwYs+mmgI3I59Y03jMzvGq3JZ6pqdfiKSnzXfLc0qOdwH7
	JB61bR1sJcg6etFicxCrhqn7/aLa2oGkoPDwdA81zf8cyX8i5+kSlRRfI+/L0nTgI2EBkeCQWzo
	4qA==
X-Google-Smtp-Source: AGHT+IFZud3Q7EnRa+zf4l7+j2mroOoVI6WsZLmo32vYCEH/+wMZNbvoVYG/kriiFUE2+7VSKhLHDP451Q==
X-Received: from qke12.prod.google.com ([2002:a05:620a:a10c:b0:8b2:4d20:bb90])
 (user=rmoar job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:2544:b0:8b2:2719:ed33
 with SMTP id af79cd13be357-8b24533e80fmr250072385a.46.1762493402860; Thu, 06
 Nov 2025 21:30:02 -0800 (PST)
Date: Fri,  7 Nov 2025 05:29:25 +0000
In-Reply-To: <20251107052926.3403265-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107052926.3403265-1-rmoar@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107052926.3403265-5-rmoar@google.com>
Subject: [PATCH RESEND 4/5] ktap_v2: formatting fixes to ktap spec
From: Rae Moar <rmoar@google.com>
To: frowand.list@gmail.com, davidgow@google.com, keescook@chromium.org, 
	raemoar63@gmail.com, Tim.Bird@sony.com, shuah@kernel.org
Cc: tytso@google.com, gustavo.padovan@collabora.com, 
	ricardo.canuelo@collabora.com, corbet@lwn.net, kernelci@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix formatting of bulleted lists on KTAP specification for new version.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 Documentation/dev-tools/ktap.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index 70f1557e47ac..d118119910f8 100644
--- a/Documentation/dev-tools/ktap.rst
+++ b/Documentation/dev-tools/ktap.rst
@@ -22,6 +22,7 @@ consists of important supplemental test information and can be
 machine-readable.
 
 KTAP output is built from five different types of lines:
+
 - Version lines
 - Plan lines
 - Test case result lines
-- 
2.51.2.1041.gc1ab5b90ca-goog


