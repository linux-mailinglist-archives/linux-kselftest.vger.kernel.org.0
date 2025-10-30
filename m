Return-Path: <linux-kselftest+bounces-44386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36283C1E816
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 07:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763F64061E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 06:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251F12D2499;
	Thu, 30 Oct 2025 06:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NeU0wavb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD4824167F
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 06:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761804281; cv=none; b=oAIP9IKZNALNTT0bOP5ie5TCsUAYSPfMLsm7rHUJOzeRDnfBTRxevN/lTb9gl+0/+pbiS96NbyGRWkyNOOkzLPaYDm+eH42ft7ga89R2VifbA1CJf0lmLsRkGlabs4z8FBJ5gRMByVn/qCzwEahGnFVS8nPcPXUvHliBdxWWezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761804281; c=relaxed/simple;
	bh=kpksfO09plUqHZfhBOrA1UHz1XN2BzwOErG5nWhcw6Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jbMFyYEJ7WyO2lAG6uhHfXDaJ+yvdsGCtU80nS9yhAxnpsIxXMFegP8361zBdPsNwo17uwj0ES9rGaukwuDGOvnNlN1cKrwneuNZ/jhNXzMlKCHhr94AS4fhzfKSpZV/9IELHHS30VqjXajOnykLIIpnFW1YsT8nhlnkSlojbOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--anubhavsinggh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NeU0wavb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--anubhavsinggh.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-277f0ea6ee6so5464825ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 23:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761804279; x=1762409079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8KenTeuFZghwFOzI4z9sTRCJCtvmTwt55CZ56oQcVmc=;
        b=NeU0wavbCVkM6GeRCoqbo1AzhbXPyUWuKJV/+tw14RYdAHUaI6SIX7SmZ7XzO9xQ2S
         dcCkeN5tf8AyaoJV6D1CjTSJ8KHxPC1UI74ly+xAgHRcg/sTwVwk7qmDPTuPgBMR2FtX
         i1DAloLqeZH1r+6K8EXJPvHYRMmpA1tDolDUOsl+dSQo647uWdi9Iwar9IIYf4gD6Vak
         LnEtDDH+UlChvCgLRdB1ml0pvhfgfsvnrfxLBMPhP5XuIoP44S103IHQv6qL4RGXyACc
         rX5u8vchdv6Om0Nkn/rjXvms+cv3u2xux/mTz554AKR2uJRvS6DhwKe+aQQ4KQxAYNwX
         7O/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761804279; x=1762409079;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8KenTeuFZghwFOzI4z9sTRCJCtvmTwt55CZ56oQcVmc=;
        b=hEukUDV1VvTpV3zvYXUcHdDL8LJ9QLlutk5rwKjVEVkZlL9vYVRsKX6jNZfjXpGD70
         yjHRK9w678KmerPchVNh+Di7V0BSswUu3UyUWbw3E1NYdMzyZ1vyYzHzNtaGlvj4f6rK
         rDm3H5TQcLAMxQPLkNlQma7kZunM8z9sFl66/iP0wuxYum25RAg4m+r4nAIsV3yOH+xB
         QZW+zmRaQilqnWyShyUHENLIV5B1hCTPPkIAnRMsiw+rihFDRpSo3qlM9o0XsHnjPzSy
         73HZX0FjXZIiXzfWwdxqcS0rzmrbpG04Bx9G6Igtv+m24EdozaLCbb7D3al+ILv9DwCE
         SJSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkoeXjZEHgL+bLNMYIf6JDxZDbE2h3CyUJo1imaka3jwQPh7/Pl0locUW9vv83zL+kEkZYdJ9XNEcFxK5hbRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu2LrYHqhGd0hhoOG0Ca5LjIDmJymCnSw54q9xU405Y7xrOmNl
	yfb3r8kAfVuZU2TFyNC4tSehYLmSoy2YTikMraqA4dC8Ndk4Zoy5PUZQV8n9iHl4fyOPjZ8TQKI
	+GpzBmOryOCvkwXxLSRornzWHwOdJ8PI8/Q==
X-Google-Smtp-Source: AGHT+IH0HjFHKiAXhz+1Aqn8OGckSLv7hJX/WjMQP572dtv2RQdzjEv6Fsb8TGmjv+IeqkKXogU8JJ4vX49ImoNHZttk
X-Received: from plek16.prod.google.com ([2002:a17:903:4510:b0:290:d109:f25a])
 (user=anubhavsinggh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c949:b0:27e:eabd:4b41 with SMTP id d9443c01a7336-294dedf467dmr65526705ad.7.1761804278747;
 Wed, 29 Oct 2025 23:04:38 -0700 (PDT)
Date: Thu, 30 Oct 2025 06:04:36 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251030060436.1556664-1-anubhavsinggh@google.com>
Subject: [PATCH net] selftests/net: use destination options instead of hop-by-hop
From: Anubhav Singh <anubhavsinggh@google.com>
To: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>, Coco Li <lixiaoyan@google.com>, 
	Anubhav Singh <anubhavsinggh@google.com>
Content-Type: text/plain; charset="UTF-8"

The GRO self-test, gro.c, currently constructs IPv6 packets containing a
Hop-by-Hop Options header (IPPROTO_HOPOPTS) to ensure the GRO path
correctly handles IPv6 extension headers.

However, network elements may be configured to drop packets with the
Hop-by-Hop Options header (HBH). This causes the self-test to fail
in environments where such network elements are present.

To improve the robustness and reliability of this test in diverse
network environments, switch from using IPPROTO_HOPOPTS to
IPPROTO_DSTOPTS (Destination Options).

The Destination Options header is less likely to be dropped by
intermediate routers and still serves the core purpose of the test:
validating GRO's handling of an IPv6 extension header. This change
ensures the test can execute successfully without being incorrectly
failed by network policies outside the kernel's control.

Fixes: 7d1575014a63 ("selftests/net: GRO coalesce test")
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Anubhav Singh <anubhavsinggh@google.com>
---
 tools/testing/selftests/net/gro.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index 2b1d9f2b3e9e..d8c29fe39c1d 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -754,11 +754,11 @@ static void send_ipv6_exthdr(int fd, struct sockaddr_ll *daddr, char *ext_data1,
 	static char exthdr_pck[sizeof(buf) + MIN_EXTHDR_SIZE];
 
 	create_packet(buf, 0, 0, PAYLOAD_LEN, 0);
-	add_ipv6_exthdr(buf, exthdr_pck, IPPROTO_HOPOPTS, ext_data1);
+	add_ipv6_exthdr(buf, exthdr_pck, IPPROTO_DSTOPTS, ext_data1);
 	write_packet(fd, exthdr_pck, total_hdr_len + PAYLOAD_LEN + MIN_EXTHDR_SIZE, daddr);
 
 	create_packet(buf, PAYLOAD_LEN * 1, 0, PAYLOAD_LEN, 0);
-	add_ipv6_exthdr(buf, exthdr_pck, IPPROTO_HOPOPTS, ext_data2);
+	add_ipv6_exthdr(buf, exthdr_pck, IPPROTO_DSTOPTS, ext_data2);
 	write_packet(fd, exthdr_pck, total_hdr_len + PAYLOAD_LEN + MIN_EXTHDR_SIZE, daddr);
 }
 
-- 
2.51.1.851.g4ebd6896fd-goog


