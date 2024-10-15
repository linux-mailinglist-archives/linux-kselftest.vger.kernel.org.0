Return-Path: <linux-kselftest+bounces-19690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA6F99DABB
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 02:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929E7282133
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 00:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8271B7F4;
	Tue, 15 Oct 2024 00:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJFsSn39"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E041D53C;
	Tue, 15 Oct 2024 00:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728952743; cv=none; b=ZQQaPoD96yOho1vio8mZX+kv/ePHtXjePdO2zchAQ0zshyItOUcMLzxJ2Sc0z6BsxO+mN393ZUQ3j4KA0FR1SOWE+ReNCEtrRWUhi71mNtKl166MFQ3+hLqdTz5T2GfivvVrCEv3EsCEu04LcE98uuD+ZNVTiRVuktnRtltUGQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728952743; c=relaxed/simple;
	bh=Uu/QsxNOdf8S2LDCiwvuhOyXQB5cTxEJcpDOEiYSVQs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FztvyGP13xFfTqmKoR6hVcZH77lmtkL7ELltYs/GgCxMxpPkvHsRuWFt7eHQKNYeQanTCjQSLLEyjc0JPjXkgkeKqqaF8+6u/ZnvTFVhGMy6LjbbXDlzWIjqDmP1ra4mnSL3MhdoVwTWhv64iLHEGJu73IxwWva3h0VHc03bH1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJFsSn39; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7afe994d519so469481185a.0;
        Mon, 14 Oct 2024 17:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728952741; x=1729557541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZCCfttGvKs7bh8i/zytwHL/iP2XyGoARtViWj6EH0Y=;
        b=TJFsSn39DiDEGtyW0l5eQWuFIcGn9HldSJrZDoSTJqM5ZLnfV03CG3bc4UHXBW5tZT
         oaQTQOz1WQOALZdfvjit0QquSVt05SWiNCXW9ol1AD+BthF6+qmmrI+4fXbuwvTtXiZ5
         7uVNlO5U9TFH1vwzVbkMfoQhLPxbEVyKJHHd3n8picjHdVnjJVC/yW8TGKAtDTdZ5ivZ
         eK0ZyRsD9mt3rz5litsx5rMowHvtFW8wpNdJmmoL/d2LO0TxCweptYx7YChG3IjzuG92
         +sztsAhVF0EmK8Nl19CgoYi5s0xvy7yuItq1uWV3gpdcZk+KNrAHMnp6rWxiByI03kxd
         hNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728952741; x=1729557541;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WZCCfttGvKs7bh8i/zytwHL/iP2XyGoARtViWj6EH0Y=;
        b=TPRLzfHHHYTifriaiNXJjQ0leW1CqqHxdiPU3uveBO4jrLeHi0MLZ7k03is8Tg+vsp
         ZNrkldG9A/LtLlE7qpIgmCncQOOC75WxrHQMbJZa+UUyttCL10NAnftNC+pIdvm5eL91
         KJZJzv2qcCWA//BsedQuA0wANQGD9QpJznStVshix5lO6po3PDdVo0qjojXZzbZjWYCS
         F5ER8F4nT/GeB7S/6b0xAbNsHkM4CAPTJUyNI0JQYuOMeMAa/sZB+RxrdIvfPsMihCJW
         31b6YivsUK8bFZt1mWUVz9bvam7avFvmyAtNxrZEVxYy+Iusl7lywdbhXL64HtRGaBwi
         OQZA==
X-Forwarded-Encrypted: i=1; AJvYcCUtp9cKnlfUlHUsZBcQIKKJTRI5HicIhGW6OPODgSNr8wzSMCgZQGJshbUIXd07hQeXmBP53cD+zgL+h+tgCUFk@vger.kernel.org, AJvYcCVo8KJhi7TzmNrXYKgIkRn7nZkx3BsVakyi0TpQqRK6UpSByfni2Ift8oyLoT1S0mE2Z9+mbzUqRFdTklA=@vger.kernel.org
X-Gm-Message-State: AOJu0YywWwS1cRUMxIEQw39nacD8S46VS5pB5jyQPso8nzKzeyejKm3S
	o9atcsbOERVnj852aZ3tbMkzm4YRAARsZgbIowuX9TtTjgyw0GNx
X-Google-Smtp-Source: AGHT+IHK/+qkf8FwHjWa7/UyVbRjNUEQQLCh6sFtcQEojEA+TOyZr1qM1Xx7F6eW/jSkU25BE1Ml5Q==
X-Received: by 2002:a05:620a:1a8d:b0:7a9:bf92:45ba with SMTP id af79cd13be357-7b120f29c97mr1721423485a.0.1728952741135;
        Mon, 14 Oct 2024 17:39:01 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b13617a6basm9544285a.61.2024.10.14.17.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 17:39:00 -0700 (PDT)
Date: Mon, 14 Oct 2024 20:39:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gur Stavi <gur.stavi@huawei.com>, 
 Gur Stavi <gur.stavi@huawei.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 linux-kselftest@vger.kernel.org
Message-ID: <670db9a43fb46_2e1742294ee@willemb.c.googlers.com.notmuch>
In-Reply-To: <6f4a506ed5f08f8fc00a966dec8febd1030c6e98.1728802323.git.gur.stavi@huawei.com>
References: <cover.1728802323.git.gur.stavi@huawei.com>
 <6f4a506ed5f08f8fc00a966dec8febd1030c6e98.1728802323.git.gur.stavi@huawei.com>
Subject: Re: [PATCH net-next v04 2/3] selftests: net/psock_fanout: socket
 joins fanout when link is down
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Gur Stavi wrote:
> Modify test_control_group to have toggle parameter.
> When toggle is non-zero, loopback device will be set down for the
> initialization of fd[1] which is still expected to successfully join
> the fanout.
> 
> Signed-off-by: Gur Stavi <gur.stavi@huawei.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

