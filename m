Return-Path: <linux-kselftest+bounces-22459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE069D6308
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 18:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541D0282A54
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 17:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712041DED5A;
	Fri, 22 Nov 2024 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzpftI8M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3DF15B10E
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Nov 2024 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296422; cv=none; b=jDW02Fn7PIWeyos0/OgvODb1xJPUBiIY5HKsH542gbmWSE1v7v8FBamlG8+m1ItiO/v9Cm4iAqUtC9sKcvvOQT0ZAXIteNsZS8O1kk1ybrTkaj8BDWpOKVcFBVU9UYFB0BHoObBnjy0hrP6WtCM0ydhhuZwfERd0J+nDjrd8ILY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296422; c=relaxed/simple;
	bh=ClLKHDqr6PkmVcgcEQS26XuKU5WAQb5CRj4MznEbpvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2nDZlvGm97qV+Fz9mmE9fAmttOKEqvZMhPsWL4hZ4JwYTWlgos/lIVI7/5sGKnj1kY+BLuFh7E2h6Wb4gigVV9oRQo/UGbGeGuaHyr6av3jncrXg+HvSMBB13vYq4W6iG0E2IgbWCRXugIHxEa7fRGnU+nbZJtMo3iSkJl7Ro8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzpftI8M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732296419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bonjTJEsrDIaVijnWhdP+tUvaZ22+wg4ayk5WPuEpAc=;
	b=hzpftI8MVcQb9YtSAjIo4mF5YWKYGV8o1YZv7fIamFPtYviYoRrNI2H73j5eDYeCpUrerp
	jWXsev7LyKgmN+AA4JQ1siibAQjoS/bVvnlWYV3GHelTutpeT+r2+uegNYp8+fmH4rmckG
	IOMmDFVwGkWO8berNWTHeaz7lcgTrho=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-seolEun6MZqMP6fsfDK7jg-1; Fri, 22 Nov 2024 12:26:58 -0500
X-MC-Unique: seolEun6MZqMP6fsfDK7jg-1
X-Mimecast-MFC-AGG-ID: seolEun6MZqMP6fsfDK7jg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43152cd2843so14971775e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Nov 2024 09:26:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732296417; x=1732901217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bonjTJEsrDIaVijnWhdP+tUvaZ22+wg4ayk5WPuEpAc=;
        b=xR/tzW+SWZhh/XtOmAyms0Vgw/RGe9xtsx0g+Dn4R0JhT2Xjhl+hHD6LOW3ljbjxVd
         5aR9z5pEw9WPFEYt7zi1ozlh23lTSd42z8lSKDp6Tp32BJVqZCAOEihkL3y9NL45ujD0
         xuq74LyBo1xmAi4J2Z3EauuVCnw50bGNNzugfyanLrWgQ4kkWE74YT4rAXfH0nkOnDIJ
         iqWwgSScdJ/BRA7m5dkVhB1UbhUJ3LbRlb+2hdOiRSWfqSOqyz3pW/4CMFha1579lAoq
         ytW8yEzZV3PiZCJwjUY9BAC0QY6BO0w3D57QwFtr2ShzIEDbxagJtWWvwiEe5TspGI60
         PSsw==
X-Forwarded-Encrypted: i=1; AJvYcCUUAFom3ixz+YyH/2YV11rd8UpGH/VkXPXaARqiDMPjX8/lu/xU/6/gljhW3Pp9SM6XXMlC+wOsnVyuLE8dP7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXLUWDhKqCI0kPJw70TEV42BifuCIOKdVv9PClZHBqURN9P4Ly
	OySd4TkBZidhu/rz7yIDuQ8WXAQWYkimqJEUueyFH7HvsZaV381JJaulL355MGGknrX3+ArHV+P
	oejsvui6kf8zAd1L1eK6vM7pmgWxXEgkIimnkCtvJ4wNQFqvbwgWm2WWynnHx37+sqw==
X-Gm-Gg: ASbGncuaeeCTMgK1/FfK9iv5ocFO21BornzYmnQIVkEIbircqtXNmTyeLfpaCeZZr8J
	DCjwg+JojgUunBobNmIYDPUH/9xCmInIuSzI6s4658IuJNEoWik9ogokGQohRdTuIelGb8zQpyZ
	/tGqlFv8rYWxXx037l1fUxzLbXS8t1D6xlZOjSkHI/jlYIW6u9GRCAgyp/7Crks1C8Qwl21DHaI
	kUqfHD3RR3lVWPIwcsE1ugXfhBwiXc8tHuQwbioTiW67lkv8Fn/H/0+cjodwjEhx98IvKEvVXd+
	dDYnLg==
X-Received: by 2002:a5d:5f8c:0:b0:382:39a7:3995 with SMTP id ffacd0b85a97d-38260b5b5a5mr3051892f8f.17.1732296417178;
        Fri, 22 Nov 2024 09:26:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ8cnKY3PHy55oSgMvuyy7GftnO8GWR0CeQCP0dYaT9/4MetPL4C2V96vIO3UU3FglDdAiFg==
X-Received: by 2002:a5d:5f8c:0:b0:382:39a7:3995 with SMTP id ffacd0b85a97d-38260b5b5a5mr3051859f8f.17.1732296416829;
        Fri, 22 Nov 2024 09:26:56 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([176.206.22.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc3557sm3016023f8f.81.2024.11.22.09.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:26:56 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
To: mhal@rbox.co
Cc: andrii@kernel.org,
	ast@kernel.org,
	bobby.eshleman@bytedance.com,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	haoluo@google.com,
	horms@kernel.org,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	kuba@kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	mst@redhat.com,
	mykolal@fb.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	sgarzare@redhat.com,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev,
	Luigi Leonardi <leonardi@redhat.com>
Subject: Re: [PATCH bpf 1/4] bpf, vsock: Fix poll() missing a queue
Date: Fri, 22 Nov 2024 18:26:29 +0100
Message-ID: <20241122172629.62588-1-leonardi@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118-vsock-bpf-poll-close-v1-1-f1b9669cacdc@rbox.co>
References: <20241118-vsock-bpf-poll-close-v1-1-f1b9669cacdc@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>When a verdict program simply passes a packet without redirection, sk_msg
>is enqueued on sk_psock::ingress_msg. Add a missing check to poll().
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index dfd29160fe11c4675f872c1ee123d65b2da0dae6..919da8edd03c838cbcdbf1618425da6c5ec2df1a 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1054,6 +1054,9 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> 		mask |= EPOLLRDHUP;
> 	}
> 
>+	if (sk_is_readable(sk))
>+		mask |= EPOLLIN | EPOLLRDNORM;
>+
> 	if (sock->type == SOCK_DGRAM) {
> 		/* For datagram sockets we can read if there is something in
> 		 * the queue and write as long as the socket isn't shutdown for

LGTM, thanks!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


