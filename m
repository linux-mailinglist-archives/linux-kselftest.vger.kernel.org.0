Return-Path: <linux-kselftest+bounces-22458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B499D6227
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 17:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 112B7B2214F
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 16:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB67B1E1A2F;
	Fri, 22 Nov 2024 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MctXfxfP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5013C1E1A17
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Nov 2024 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292481; cv=none; b=PCLmCh0JzyiRlP6iFkDcRItY0ctxkx4sCcNto6g6sMVoA4NnYZMNwBr877KiNsF1MHKqpIX6lOYOmcMYymTo9r1CCYEeTvBG37RYuSypo6BbhHGPOYiZfupTit2ParmmiVNcJmk7b6TFi9tewcxumYvarjvFiVkj2uCfiO+M0NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292481; c=relaxed/simple;
	bh=qKtTB5DV3Zl7Y+bAH9RuF3TD9YvDTYHWYvVeSislgT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4WXKwdx0wPeYmHixe+IQMyp8gBRQaChhzDSttUWUBuPpKv0WCljTRxmM5B3NGyJ5dtoaSxuhFnQJvOhsNU95wErItJxmCtHtq+52XVeMhsopht9O9VA4P/ocjtJJqgGNOsXgWTFo4MRh+ScWCx+9X1lQ0lPkoPRRqPY1xISp+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MctXfxfP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732292479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qKtTB5DV3Zl7Y+bAH9RuF3TD9YvDTYHWYvVeSislgT4=;
	b=MctXfxfPobufAJTIZN1DFV1XrTqVYArGsgZysGxdZ22pctOnR8obDojkRN//qpmJlZm9ap
	oklp/UsRR4spujdGbQIfSYbRfAFC3mNfAPv9kQ7KjBFcEwC2MP/bbNJhoI1iUW1ATFhdy2
	Z/fifoAG6t2KxIn54yyLzjAz/AndwxQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-TbVwYSeWPnK9myUNv8tmnA-1; Fri, 22 Nov 2024 11:21:18 -0500
X-MC-Unique: TbVwYSeWPnK9myUNv8tmnA-1
X-Mimecast-MFC-AGG-ID: TbVwYSeWPnK9myUNv8tmnA
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-539e75025f9so1457881e87.3
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Nov 2024 08:21:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732292476; x=1732897276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKtTB5DV3Zl7Y+bAH9RuF3TD9YvDTYHWYvVeSislgT4=;
        b=bnrmcA3CUdm3FfoL0bya8lCNN5DDBk9L9wBl9y0Pe92Z1nSL6r/3/a6y5CV0h7J9G6
         u6INx7dU9D7vBag61Aiexxi7T8KFX2MGsk4wxRJB8vNNmnLxM8smqYtBnwR2YfQRy9cZ
         QTobPaqdtbRonhobak+U6opM+ND237JwPYew8fZ0HdUv7QPqrDCyYM0+tscS+amXFHw2
         t3FLZSoWw+Ijf5FNd+SGNitmlhmAzbi1UVBr1veTIQaxORU3Ntya6p2DIIJ8805JYmdl
         60zSmz/83roBqPK9r6bI4pcl6PYhZpVXY6ypq4V3Ds0GBUeVeBUtORMlyscxlC8Ql8nq
         xG1g==
X-Forwarded-Encrypted: i=1; AJvYcCXyoIE+cGlZe9SJPkqy3ammFBur/QsJb3QBjR4Y8pJqNmqpPD0jOckyAtvFm8PYkIz1Op9tKKlhYF2b6NUs2ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIi+XPOtbRFTWzkuaOLbiCkSBdONpTca2tm+dsDfOyXQM7jS4m
	X/W3erAjDLSG6Aq143vjfhtIwez30TZharJ2YySewqciAmM5M5+0GlaS9hkogLvocQNmMlgNDQN
	DossdjfmOK1YRjpLKwO90V3HeE5xCKltp+QTezMwb9AgKCOddC+yCQpMUqoLGFEubuA==
X-Gm-Gg: ASbGncuEly+8sB9MtoVgj8HErlUEnwf8QCfaapW31OZ89owH74QuDzP/uhfoMKavSz1
	DkMZYE77CikaVojrrUh/ccz5u4ajf0sKXh7ceSw536dFULCFyUcTr4YI78WpjILgqb5bSZJNRTd
	PBucFT7QNT+0hphA2+cPjSIQCzjd/cbbPghpjRtlD3ztc4m5duWc6MiavmXmyFRSM5z+aQwk5cJ
	PaeH4RH280lPb/4CuL32e0A+7S0ZihegOH4I3XaKhdfCbN19ddmMYY3qJJ8fNbFo06Y1i71H2yf
	b7rgXQ==
X-Received: by 2002:ac2:51c9:0:b0:53d:8c79:ace5 with SMTP id 2adb3069b0e04-53dd3aabeffmr2344606e87.54.1732292476497;
        Fri, 22 Nov 2024 08:21:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR0ePfE3lovnWGuzpFCv2uMYuHyzHPO1LZjbHFLMvu00pbafujzeSDjCej37Sftl/YHlPHDg==
X-Received: by 2002:ac2:51c9:0:b0:53d:8c79:ace5 with SMTP id 2adb3069b0e04-53dd3aabeffmr2344568e87.54.1732292476130;
        Fri, 22 Nov 2024 08:21:16 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([176.206.22.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b463ab5fsm98768945e9.27.2024.11.22.08.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 08:21:15 -0800 (PST)
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
Subject: Re: [PATCH bpf 3/4] bpf, vsock: Invoke proto::close on close()
Date: Fri, 22 Nov 2024 17:20:31 +0100
Message-ID: <20241122162031.55141-1-leonardi@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118-vsock-bpf-poll-close-v1-3-f1b9669cacdc@rbox.co>
References: <20241118-vsock-bpf-poll-close-v1-3-f1b9669cacdc@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I spent some time checking and nobody but __sock_create (net/socket.c)
and vsock_release can set sock->sk to NULL.

I also ran checkpatch, everything LGTM.
Thanks for the fix!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


