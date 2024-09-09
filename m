Return-Path: <linux-kselftest+bounces-17480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788E8970F11
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36911280E0B
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D652D1AE03B;
	Mon,  9 Sep 2024 07:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7e4nLbi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E8F1AD9F7;
	Mon,  9 Sep 2024 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865714; cv=none; b=GMQksTu1pkYe86Jfe8rfcecaxT9oEVMlI748I/0oziGlY1OY+MQV/KlGtI9TD5w0xQJ0swU2A6tqEnD6SLW+eechrwsvbk+TL/E65E5CYgAlArjmbVZhDK90KTP47m4CaDLbDDugDU2djVE6eCGOcvjLZto3pOPdcJoVm4OTMtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865714; c=relaxed/simple;
	bh=ScXljYfb4gZ0j4RvtMPh0B1lEYoMVRDf4adoO8flAvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDzhq/GPX/VYX74JnkQoQTxU0UWhSp/F/c0Sfd/cWQimIVcGpAnyRgP4P+9qwn5oFLvMJ177OMSasT1zqXytt+54wEM39X1IzExQ119R8dZP1ZPK1eOnNLe/pfPmPIxzM3+HNa7AOmExKUZBnuueXpQzX6AySbEQRXwRO0ICgXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7e4nLbi; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-374c3eef39eso2225577f8f.0;
        Mon, 09 Sep 2024 00:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725865711; x=1726470511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJ+e64efHlSgzeDsuneltxPlkbdvNmJYnADy0syd420=;
        b=e7e4nLbiTTYkT8YOX9n15WRZKByi+8y71Voj4u61QheKZKo4c6GvX1F3CFI6EQLqPS
         gti0t+2AIf1F9xT4TnoVkFF+56NeQRVcW0aISpZhI7qumPYishkmeYQ0bL8aWo/tD34j
         5fBbI86vjcqLj97Bb91pKlK/qzp/pj139Dm9tO0phuO/4CyRP9si/7AF0/+nxp+mXi85
         i25MCS/5jaHqcYUtA2FAItoM+vzIMfTHl7ZLwed+QRI+f9Gjh+jhroqJXh8Qprxkb+AP
         u/5HXFcOt8vt7NX4sh2kuI/qrkFDBuvlyr7sYg1BhnDxtXYurfCMxVUejrpfgDpIIK7a
         y/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725865711; x=1726470511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJ+e64efHlSgzeDsuneltxPlkbdvNmJYnADy0syd420=;
        b=LWZzT9bLpZi3exPueijcqx0Qv+emiGeIc0ee/kG5+2J0FQ+OuIakmJ5mXaZcIX4pC0
         LhmCIO3CJSbVGuxhepksiRHn4H6XZcoBDjx5CdtmT0ouS4XOemJ9OCzrdLlbwo75Vf47
         kNee2Q9xZYmriQrN2LtK5zHXxCxTb2h3T1xty3To6wrzQ3E03LRO4GUxAjDmeVBJf1Or
         7tQr9yhYevvZ4vFK8ira5Kjsz+VLCg/S/1pIESmMFdpdIf1dWNmYxL0eEGEGOwXseur7
         KRXdQnasghSMtalMjvm7TzvwF6aIdnVt0pnOJQcF7A8a46483ViUayIMIKLs33DNJ07+
         C5Vg==
X-Forwarded-Encrypted: i=1; AJvYcCU9xlnavhWHijeKSR1fLcGNvCjysWyUC/zU1oAcZXXSkPhhGz9hpCMGWAElo319JgrjDBAbH6dvnpuVaqUJ@vger.kernel.org, AJvYcCUFgA6CWGxY44RIOWEczu15LbVvh7wQXziA7X6ErLOUHLbxXr2TZxnAXycUCyTiYa4tRHIG/Rf5D/9Lk1Q=@vger.kernel.org, AJvYcCWIxyGMaKWEOSQcj2e3QhPcvDu2ReiODIxOzVAtjqd/+6XZzhnFCvBsaoAof0Lg4OxHT/GhjOBwJ2TB5k79GA==@vger.kernel.org, AJvYcCWOhUySDu+HKRHqQ0zmiNP3ODB0ymUALmblhgIfPsaxGzMQVOdOBrqlmX20FQo6ISN098k=@vger.kernel.org, AJvYcCWqOKv1a3kg5exDp3xaoLFXj2N1kCWfE3e26SlRUCqjtoGMckBE9oVdk8yQcWIoa8iM0XyHFr5pn0UvoQ==@vger.kernel.org, AJvYcCXI8/eUXGrvITx/6zHOvq6AXBPU+zQfiKld9fwOf7+/Il05iyGXFtYkF8BAjdNxiZuV8fQ/fqEldv1CVtsTQzh/@vger.kernel.org
X-Gm-Message-State: AOJu0YwigWf3yMXkknQXDmKTCRZZwiyZ5/pgQ8h/Cr6mKKtiB+naWmek
	u3oo4D49zbbkv3a3EjBSY96q16ugVKLH1CoVjngp021hsn8aaJGT
X-Google-Smtp-Source: AGHT+IHjuyDeJOTuWU6U99A+nUhTDj2Ftw6vRJiQ+Ht+n2ZbU24Uupr5vdNYk+vcq93VCNsDOFt8cQ==
X-Received: by 2002:adf:b305:0:b0:374:ba70:5525 with SMTP id ffacd0b85a97d-378895c32e3mr7328314f8f.12.1725865711376;
        Mon, 09 Sep 2024 00:08:31 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d375asm5178754f8f.66.2024.09.09.00.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:08:30 -0700 (PDT)
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
	kunit-dev@googlegroups.com
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2 09/19] bpf: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:05:23 +0200
Message-ID: <20240909070742.75425-10-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909070742.75425-1-ubizjak@gmail.com>
References: <20240909070742.75425-1-ubizjak@gmail.com>
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
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7ee62e38faf0..3f0d1eb7f5b0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -21,7 +21,7 @@
 #include <linux/filter.h>
 #include <linux/skbuff.h>
 #include <linux/vmalloc.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/objtool.h>
-- 
2.46.0


