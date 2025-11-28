Return-Path: <linux-kselftest+bounces-46691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C849C92489
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 15:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B661B34F7FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 14:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009EA274FD0;
	Fri, 28 Nov 2025 14:21:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA1A24DCE5
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339659; cv=none; b=mWumewXCPY80iDhtZnRNlUAKosTCtpupJ0Y3E053cr3bUyp1kvtjNfQNCapLGnGtgN5Bjl8FaGg7V3c3ChRbfjRqrqFq+Mbo3ZMMCMUp38kDGQJ+V4EQ11jIomxIJ06tz2O2+YMwIc5SqiqIvdMkS0oh37q6BCQWjcG7LP78smw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339659; c=relaxed/simple;
	bh=8AeeNuKarsu5qA34c7lNeF8QhulWBTrnEQ0CggOIbSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mC42IjNE+yEORCkItQap6QnxZFyX7useTmUZ+cmX6XQzIrmaj86mdqF/4E4i+TLoI5zBpBg0DGGRZTzoGJkkqSaetPtf7zCpds9fdmiOLiHYtMpkFTgcaD1aM00aZ1WUTJ+Z8GW53f40qSusmVEyYwk+/2zJSYIwnAtj49hyfEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c71cca8fc2so1138183a34.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 06:20:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764339657; x=1764944457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IO8fpf+Qe7KA1hAphkMPr2BDEzo3Q3M23aOQSgVd6Z8=;
        b=h5/NQ3MXkvoik8dFqBGwnopDANFfUGdyKY+VmQWDTV6fU9G9BFl5CNwHWgSZEkYVv7
         9byhQEoX5UuH7ox7eiPsPLInsQvDuiXcQXU/HDtohxjntfwMaALF0miU1+NoBr1OerB6
         6ZwR95hTA6HSSaC/9nyiF2cH6UuuP9D/1zQwQV+PtuETAwwBmWsP4z/YSicIfY99M1tV
         jE1Iwp3sapIONS09u5loIUaBhjvo2Ui5UFy5Bk5gn7qqCqD5fhUULqU+bhMQSquJQ8P7
         RCRioClG7T0ZotUNhRoQqaasvYJKQ5nM6VcTueby1547TN16zbZVSV5ghv/XyGgEZKhz
         2aIA==
X-Forwarded-Encrypted: i=1; AJvYcCXGpxT6Ryn5g0tA8mamzpFAACQKRZzZ3ckui4/hGAmcFE5EoSslK+1xHMoN+0pd/n2DUgnyfMN4+rlFSfYKPvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBwspVJjwApJeCOyEIpE4pkK46Qe8SowghCfMSDYue1E2I4uS0
	PylIZ3idUhqstSjbn4s+AE2NsRBJ9ZgNjUa/V5RWzdLBcJh5uQMLA1UH
X-Gm-Gg: ASbGncv89/0V9lZj/TrzD0U/j7vlck+MvTchnjduuESXsxXVLKTafKDyDipK5KIFjJU
	wWc7OlwNNC4cah/XZwgiIEjDL0YUwqFddfJQBzTuK7vthSRzutbIQyttG5qO3LhHqBH3tyhEbfT
	sBtATNgBx43vp7tcqkvYCbRxKCiP57p8g8IR05qHPAjm54mizHpaYqfL04Sr8VTrTNUzoxtNDxm
	r+4cO1MPNwS5KSfHaR+npaRqQhJcXafLFzgIYqBF2pZX1eXyQ/TVRt+8PZGi/Teox0+5ydJxuAw
	PDl10TrzfKx534UDeKt4CsxHK4/mpJOtImdCaUKzXWwIDNKzBjfDdLnGV9Z/ExgPfOTjoIlfAXb
	tf3vqX0Ge6txqESKbUOKdrBALSPm741glqTkpkS1r9urv/9lDY7C9IUjzvN2zz7Cv+isO9V+fF5
	zHjviv8nk/IA==
X-Google-Smtp-Source: AGHT+IE8Csv0x3Otw25HTHmycCm8OmZBQcHgbovfIus9/bAoq/UixullE88axucO5VUxe/H7t0bIYA==
X-Received: by 2002:a9d:6143:0:b0:7bc:f443:fa3c with SMTP id 46e09a7af769-7c798de468amr11684101a34.25.1764339657047;
        Fri, 28 Nov 2025 06:20:57 -0800 (PST)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c90fe0b238sm1586166a34.20.2025.11.28.06.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 06:20:56 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 28 Nov 2025 06:20:46 -0800
Subject: [PATCH net-next 1/4] netconsole: extract message fragmentation
 into send_msg_udp()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-netconsole_send_msg-v1-1-8cca4bbce9bc@debian.org>
References: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
In-Reply-To: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org, 
 kernel-team@meta.com, Petr Mladek <pmladek@suse.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2049; i=leitao@debian.org;
 h=from:subject:message-id; bh=8AeeNuKarsu5qA34c7lNeF8QhulWBTrnEQ0CggOIbSI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpKa/FePe42auqDY/Qs7XpYdwbHd6fJqLNwggTf
 H3VVdrUTfSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSmvxQAKCRA1o5Of/Hh3
 bWEJD/45t6CqWMn+sI2J6+MyW697ZsxhgZ539JQ7X8cHcLAwGA2l4VRPb+vljF+qZ6sV6BJCeZ+
 Tsxb08lgFu+44cvvEKSO59GXsfsKgGPRVe3obqlCcy99XLONvtOjT1WZRgN9L9h85HG/YzXOoeQ
 j/17CmNiqgeRNwjiZDCcgnJqbsUlWumE/8WoI+8lL+AibpkKcKkTW2Bdil74n6zYF1k2tWDB4Cs
 9trke+OdIrF4b47c3a91ZBxzdZi0918GKat/sKevUD7eDoQBrLOeQmiP+ZIv09pCBavFFquA86k
 ZPZg9i0CuRkCGQpwew0n94sHV78imAeHK6n+H8wKzKuBTgQ0hh+aCyU0X5+CIXOOMMz20jd6Qft
 d0H9qaOjkgbkP/t/YV9Up71zlF/DOlQDwEp1wDXtlH04PszFsRUhJ1VqDZksJLoAMl/owzcDQ50
 onheqsBZqT6IwvdImVa88fwcS+02optkhu9kSZQXt1u+TWJ87RcJ9VcRJ+KJIxbudo6oS8Is0Iy
 5cKccRhcZFN5qjxN0JfVJfVRMUfXRT5o5yGUYqw8TqiV/UO9KTDSy/tr+HuynBy0skfbitfVx8t
 bL70JidMIQe8IOrhsngRbjrw/PEnjEoPbx/JRtpotnia8TJrrLh+K4S0PfdLjcyxncZ6yUtRwQX
 Vg52jnE6T2U5QcA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Extract the message fragmentation logic from write_msg() into a
dedicated send_msg_udp() function. This improves code readability
and prepares for future enhancements.

The new send_msg_udp() function handles splitting messages that
exceed MAX_PRINT_CHUNK into smaller fragments and sending them
sequentially. This function is placed before send_ext_msg_udp()
to maintain a logical ordering of related functions.

No functional changes - this is purely a refactoring commit.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 drivers/net/netconsole.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 9cb4dfc242f5..dc3bd7c9b049 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1725,12 +1725,24 @@ static void write_ext_msg(struct console *con, const char *msg,
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
+static void send_msg_udp(struct netconsole_target *nt, const char *msg,
+			 unsigned int len)
+{
+	const char *tmp = msg;
+	int frag, left = len;
+
+	while (left > 0) {
+		frag = min(left, MAX_PRINT_CHUNK);
+		send_udp(nt, tmp, frag);
+		tmp += frag;
+		left -= frag;
+	}
+}
+
 static void write_msg(struct console *con, const char *msg, unsigned int len)
 {
-	int frag, left;
 	unsigned long flags;
 	struct netconsole_target *nt;
-	const char *tmp;
 
 	if (oops_only && !oops_in_progress)
 		return;
@@ -1747,13 +1759,7 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 			 * at least one target if we die inside here, instead
 			 * of unnecessarily keeping all targets in lock-step.
 			 */
-			tmp = msg;
-			for (left = len; left;) {
-				frag = min(left, MAX_PRINT_CHUNK);
-				send_udp(nt, tmp, frag);
-				tmp += frag;
-				left -= frag;
-			}
+			send_msg_udp(nt, msg, len);
 		}
 	}
 	spin_unlock_irqrestore(&target_list_lock, flags);

-- 
2.47.3


