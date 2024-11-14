Return-Path: <linux-kselftest+bounces-21997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC029C8108
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 03:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC650284DDE
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 02:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F331E7C0F;
	Thu, 14 Nov 2024 02:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cUQC8PNl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977B93D9E;
	Thu, 14 Nov 2024 02:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731552624; cv=none; b=rt9W+ck94C1V1zcEBUzJyH2hW3gfSSJb5NaG9fiAk8B5GR5gR1YHoHtdnGPOlz5oFrHjpILh+MC/5MKrb2t/pa3q+nffi4tIeU7NE3jSdzkfz6byXGCyOBnduvxfscIXteMLGfZ2ifQP++M0R4or429oFzVf5rt+stU+T4YLGJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731552624; c=relaxed/simple;
	bh=6l5Kz1Vo9Vdfhw8FNuLIO3ykNDBGv6861t8VwWdIquk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QYxOb3VNaeEHK/YIsgcg3OvKijXRPkDUVxwsxCtoG0uynLlr9xXJ7fhoh9Rne6jE6VWR0FL2u9OxtVo87jilS+SJJ41o1cDsoznT3B8OVsAyeigshQpIywul1ECEqquLUwGLRzENbw/IcrxxV7Ki26QLy9Yy9jyacetDt2sizZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cUQC8PNl; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731552623; x=1763088623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WV93mZS5kqQSypy1nAkSsyu48bHJZ86isxlJ7Z6bGP4=;
  b=cUQC8PNl9DtVt36T4JmBhhEpjTJDdaghJMlXOY60mfsittovRnFNnv3h
   y0SRUqzG5mccmrjJS7EtUdffLGJY8s/QC+1ajldJ9yhREsSX9220+ghU8
   WphnYHwG57iEgpHivurFhbwF8nYXTKrSn71EDwYoADWOFKAcPjTErdvxr
   A=;
X-IronPort-AV: E=Sophos;i="6.12,152,1728950400"; 
   d="scan'208";a="775497976"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 02:50:17 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:21604]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.85:2525] with esmtp (Farcaster)
 id 3473ada9-3da5-419a-ad22-b3ebd80d5d47; Thu, 14 Nov 2024 02:50:16 +0000 (UTC)
X-Farcaster-Flow-ID: 3473ada9-3da5-419a-ad22-b3ebd80d5d47
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 14 Nov 2024 02:50:16 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 14 Nov 2024 02:50:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <stsp2@yandex.ru>
CC: <almasrymina@google.com>, <asml.silence@gmail.com>, <axboe@kernel.dk>,
	<brauner@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<gouhao@uniontech.com>, <horms@kernel.org>, <kees@kernel.org>,
	<krisman@suse.de>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mhal@rbox.co>, <netdev@vger.kernel.org>, <oleg@redhat.com>,
	<pabeni@redhat.com>, <quic_abchauha@quicinc.com>, <shuah@kernel.org>,
	<tandersen@netflix.com>, <viro@zeniv.linux.org.uk>, <willemb@google.com>
Subject: Re: [PATCH] net/unix: pass pidfd flags via SCM_PIDFD cmsg
Date: Wed, 13 Nov 2024 18:50:07 -0800
Message-ID: <20241114025007.99331-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241113210206.3440784-1-stsp2@yandex.ru>
References: <20241113210206.3440784-1-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Stas Sergeev <stsp2@yandex.ru>
Date: Thu, 14 Nov 2024 00:02:05 +0300
> @@ -154,7 +157,12 @@ static __inline__ void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm
>  	if (!scm->pid)
>  		return;
>  
> -	pidfd = pidfd_prepare(scm->pid, 0, &pidfd_file);
> +	err = pidfd_validate_flags(scm->pidfd_flags);

No neede to double check here, it's already checked in __scm_send().


> +	if (err) {
> +		msg->msg_flags |= MSG_CTRUNC;
> +		return;
> +	}
> +	pidfd = pidfd_prepare(scm->pid, scm->pidfd_flags, &pidfd_file);
>  
>  	if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
>  		if (pidfd_file) {

