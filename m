Return-Path: <linux-kselftest+bounces-17194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEAB96CD15
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 05:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73A1280C43
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 03:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727381422D4;
	Thu,  5 Sep 2024 03:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqlH9O6I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FD025634;
	Thu,  5 Sep 2024 03:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505960; cv=none; b=e5IHoMW4GPjl6MZP20uulWVYDv46Jh8Lruwv6JJMgbalg0ee8MjBaWwLFIxqgB9/uGDS38EbVt4EOHw4pbGeAvBUE6QBN82dktl0keyZgEIia/fDjakPloRgHFnlKsIK3/ykMKlrt+6EslZ8oXONyzess0G7aUAv4Iu863FhMok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505960; c=relaxed/simple;
	bh=IWCIwjKm2nd9+IsNDo3qoVhvsSPr+YsfPQJr1w33aJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QvAMzi9GzrwbHVPUV855krHnULnJ867M969ML+Jo7j9pMHUOtm7DIZa3u5LLAEYIKdKjLo7E2vZEDtBdWEfLYGwUXYpYjG/fJk21GpNFUiwNbJAmN/hdXwO2+yE4XezAuV8ivluEJ5alAqcJGBB/YhfNpPxqCymgRhvEiRlRhZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqlH9O6I; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4567dd6f77fso12913721cf.0;
        Wed, 04 Sep 2024 20:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725505958; x=1726110758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x7/9Vt2xXlQ2dSKa7SiPYmLRohxGt5ZggCzkXT/M3nM=;
        b=GqlH9O6IW+oVlmeQ30XGdpq27B53J29hn1y7zHxLdiy5+EhjfcMmXvW7YHVAs//MfF
         +Jo6NmFwgF8lO4VlV/+fctSg8ZZS8H3xBxkzHSThOhFeJ4WSNixDlWNN6fMxBC3HmRhO
         cTze40igcPo7oMv99VANinkMEfAcTqwtUmWFEDinPA8avBtV5o9dFsubKc3Kx2z/GL8I
         070sH/j8eUgIqUmVIS4NnkNZj9sNS58TS/MnxXA/PPj4neG7fwM71yl6auGJ7y3JmHIT
         F6thhgsYmzBHcUVZidRoe2UULBv6LxPY7mcP33SQt+2kjARE9lXF8jvFh3QEDztG9/Fy
         TxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725505958; x=1726110758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7/9Vt2xXlQ2dSKa7SiPYmLRohxGt5ZggCzkXT/M3nM=;
        b=QeXvrHEh5B4sKHwNGqEXpW02+seOut1kkSREhczsQAa0OMCDQfVI005TGthvmyqIOu
         t9+IOIqI3A9ZkmHxqgBOSQxbiFyDm6o9ss9CRHWkq5MQYn34/PbHEBEj1fBR4zUumPTZ
         VuafQYMrdxk9N/ml6hP8Ak7sRiRLQ+uTwIMN4mgxJKWGlcVsnqJ3Z91/62ivrJo15PlS
         J/pAOGENLkhAKnj4jotwlp3v6ojlgwjhqQpF/MxiB7nQNl2DOu7La7vgPkviFRcd9fQj
         CElX0+honnbC91Mu4VyGZvX39iCoZ1eWPMovKLfd6m5tfBONME5SENGJfgypbzMkmPjp
         mHvA==
X-Forwarded-Encrypted: i=1; AJvYcCWrkGT2W4chL4e47kGzBWqFpVAN5XXB8hIcqKoviAn1gpZ3Ujdb+/8IVMrPBzHcifO+fzqHLZuVJlyS+evQLdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA8PDkRzPsPKMPIw4hQAjGXWEBwg30OgoVwAwqcZuVcxKeFD6U
	84/xDidAHdqZoH0y5fjMVlgOx0j2D49hmXXeYXfy9fkmnISLg2ODA319Dg==
X-Google-Smtp-Source: AGHT+IGvbSYWPr9tusOmgprKh6+nEjbCoiCaRbwcW21LQVwREPz5HmWahYmQvjE2hMDflNbDQnZ0JQ==
X-Received: by 2002:a05:622a:1184:b0:447:e6f9:f61c with SMTP id d75a77b69052e-457f8c63727mr74162601cf.22.1725505957527;
        Wed, 04 Sep 2024 20:12:37 -0700 (PDT)
Received: from willemb.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801a153f0sm3819611cf.12.2024.09.04.20.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 20:12:36 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ncardwell@google.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	fw@strlen.de,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 0/2] selftests/net: add packetdrill
Date: Wed,  4 Sep 2024 23:07:01 -0400
Message-ID: <20240905031233.1528830-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Lay the groundwork to import into kselftests the over 150 packetdrill
TCP/IP conformance tests on github.com/google/packetdrill.

1/2: add kselftest infra for TEST_PROGS that need an interpreter

2/2: add the specific packetdrill tests

Both can go through net-next, I imagine. But let me know if the
core infra should go through linux-kselftest.

Willem de Bruijn (2):
  selftests: support interpreted scripts with ksft_runner.sh
  selftests/net: integrate packetdrill with ksft

 tools/testing/selftests/Makefile              |  5 +-
 tools/testing/selftests/kselftest/runner.sh   |  7 ++-
 .../selftests/net/packetdrill/Makefile        |  9 +++
 .../testing/selftests/net/packetdrill/config  |  1 +
 .../selftests/net/packetdrill/defaults.sh     | 63 +++++++++++++++++++
 .../selftests/net/packetdrill/ksft_runner.sh  | 40 ++++++++++++
 .../net/packetdrill/tcp_inq_client.pkt        | 51 +++++++++++++++
 .../net/packetdrill/tcp_inq_server.pkt        | 51 +++++++++++++++
 .../tcp_md5_md5-only-on-client-ack.pkt        | 28 +++++++++
 9 files changed, 251 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/Makefile
 create mode 100644 tools/testing/selftests/net/packetdrill/config
 create mode 100755 tools/testing/selftests/net/packetdrill/defaults.sh
 create mode 100755 tools/testing/selftests/net/packetdrill/ksft_runner.sh
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_inq_server.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_md5_md5-only-on-client-ack.pkt

-- 
2.46.0.469.g59c65b2a67-goog


