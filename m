Return-Path: <linux-kselftest+bounces-17505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A499710DB
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 10:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B8621C2219A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 08:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD0E1B5EBB;
	Mon,  9 Sep 2024 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W30Mo0mn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8101E1B5812;
	Mon,  9 Sep 2024 07:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868629; cv=none; b=CdAC4dNc9we0HidxV94UIdRY2zZLDyJqR0Fl5NR1Uiwoa6XDUsU/JMZMMOzcGZgUN/WUOXgR19C5AUtn/BBbIOo27xo8/4v544fqS4zIo7d5NS6o8Ti38Sw/Rs9k6N2WnBf75NDFW0SwHGUM5WDWalq4pO9d/WWKgIDETXiVB4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868629; c=relaxed/simple;
	bh=gb0OfLUDlHD7TLliPPBr132d4LP07Ahm/gQRxup40Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqD+/ICBtBuiVN7BB6lEKmkfBSanPWOErbht3vCnfm9Rxn0Np+roiSfmQxmvelbfs7X1RcZd5KscwhlXWBSrW6Dyw/GvoaiDj3woM8YZ2qS3trHhSsyi6ERyUPgGnIP/oF30s8YLkqJ3qXJkwvFTlk3PyF0yXfUL+pBtxx5hzuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W30Mo0mn; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374bfc395a5so2284013f8f.0;
        Mon, 09 Sep 2024 00:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868626; x=1726473426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KT+qqbFYGAtbtTrUYL5Ww6m96yHmU9B4q+0V5LkESPY=;
        b=W30Mo0mn8RxsTGFdpPmzGMd0BySFJ0Yt/cgwPCj+qvrdopQWsx1RdCjvV+xig5E//v
         F5Dxbm2kqcL8m2T67D+OoUNWX+Um/HonI2XAha33ekH4pp9zne3m+QJ0saLoFGy95Ypp
         qhfYFk3XXdaPONo8xglhaFYs3VchKcKp++RSrTHQDMI2q0C3BcN2Ihml/1uiyiJCXmFE
         m3dTWGLQGXt5uuypCQ/+9xuDI2KVwNIG3A7h+Hnx9cd/7GD0D9qSigJFsKyvAHogi54u
         y7NENMW0owOB6iKiPnpvlIR+xmgTg48AXlRp3KZvnGvbDwLSdiAQrlylg0cRJ1mcfIsp
         EAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868626; x=1726473426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KT+qqbFYGAtbtTrUYL5Ww6m96yHmU9B4q+0V5LkESPY=;
        b=omvqHYh8wz2najp+ARZ8d1rjIwoP7Te7xeBeUFEaEK6zTUwzUPI844XQlN+lVKcnfY
         2j2ygIy3DSn7rS+IzOYdBZFeAjL4AzOc8v3yYm0XwGufybPHGvjFu54G6xrqJoCt0XA2
         yzCaGNyWafS2d3xMj1a+GlRjl8HhDleChs9bZQODfwcckh6QcbENpApGxNIHbvGRTLQ/
         bSNoU53QJbasRXw6j6VxsHq+yVRs4zayZKNS2J0Lx2L2Zq1jbfTbTGCxr96nspHA8vWd
         H64El7An/8Mq0ws5Fe9GbhMiuLqmnR3OSVtIrUfw4F54pRHSfz1EVs2pIo+wvNwHnCMv
         pBcg==
X-Forwarded-Encrypted: i=1; AJvYcCUIdpPzIw05eisU6Hg8gx7rtGtnWHDu6RF1epMGZtachMZ81DLvcWhsX3I/mdAHfjG56rjGBgH4JqSbX5JT@vger.kernel.org, AJvYcCUS7AlR1MGcg5DXWgRvtBynGVPrO7e1CP+D66/WZIWnE+Us+K0OyTyWePajcBv7WNTml7lsi94RkqnztSI=@vger.kernel.org, AJvYcCV3YJnk1I0JknpPuBHhVyeeXryhPA2au3hAMJzJLoMpszLpvmrXwavdb9Tnxr/s/nDEyY5LNFuklLvb4A==@vger.kernel.org, AJvYcCV85n27EHGPscg9sXBKHLxCUISStP8qzX6mzjxNXHEMMA+bZaEd48KSGHbiwvfamWRwFV4=@vger.kernel.org, AJvYcCWuPz0brqebUStC8WqpIur3o2dTYnsr9vBBTZpH1ANvephdqB2l0aGSLfd4S98Q3LMTgzcwKnqs5HnlwPdP@vger.kernel.org, AJvYcCXOaT9akXrwLul3IPD6+vGWuMfzBXXguSV6n6csyATwrmmS7XMlzmwj6Io2TdbNFa3Dn/zUeqHcq1UQEjkQPWUf@vger.kernel.org, AJvYcCXY8DdRt2p9QAt8fyhnk6RKLlUdOIRmwK0/iBGxkpWtM8XfSHWzozkMLY6/D2Gt9us9m0oASp0A6R02HPejFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT/Vm2UwuMyN+zhSpN/kwkxU5N9u8T22k+gGCW5XgHMktsIvBi
	+X494jVYqJAnNPiMZcrhTIcjvvaFWIurBoTUQsaEMAFJsk9uGl1M
X-Google-Smtp-Source: AGHT+IFPgZJXpjY5OiDYTjI08iQ6tSwI+j2L4W948bn3btzf96vyOqo41buC3MxpwztDunJSgtrhpQ==
X-Received: by 2002:adf:a395:0:b0:374:adf1:9232 with SMTP id ffacd0b85a97d-378885f1a1bmr5455621f8f.19.1725868625748;
        Mon, 09 Sep 2024 00:57:05 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b7esm5303001f8f.50.2024.09.09.00.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:57:04 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RESEND v2 12/19] random32: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:53:55 +0200
Message-ID: <20240909075641.258968-13-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909075641.258968-1-ubizjak@gmail.com>
References: <20240909075641.258968-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Substitute the inclusion of <linux/random.h> header with
<linux/prandom.h> to allow the removal of legacy inclusion
of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 lib/random32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/random32.c b/lib/random32.c
index 32060b852668..31fc2ca68856 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -36,7 +36,7 @@
 #include <linux/percpu.h>
 #include <linux/export.h>
 #include <linux/jiffies.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/sched.h>
 #include <linux/bitops.h>
 #include <linux/slab.h>
-- 
2.46.0


