Return-Path: <linux-kselftest+bounces-25864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8372EA29BB6
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 22:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BFD418849CD
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 21:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78834214A7A;
	Wed,  5 Feb 2025 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1fK+JId"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F6F2147F9;
	Wed,  5 Feb 2025 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738790056; cv=none; b=dVM1ApuqymJTtdE8T4n3KEupDy59rph23tBAwZm1c5eVyBNRDoY5FTtGxLVukY0YhdtFQwFtruP/Of/yQq0un5oUy6P762AezhlSb38WR8DNjDZC3MfRw1sWO8NWehiSpZhx399DclqlFhpz/ai6wpjO6KJMCtum0N9nO/z11TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738790056; c=relaxed/simple;
	bh=KugHMl11lphY7X+eKVMkQ7YSdoECqG16VgpjtDZyfhw=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nY7U3349dl2D51eEUsq+0LtJ8EzM4jAkYe5zmxC5hnYyKQ6eAn/f+jhdF++QbpglagyhNJ+NyxPPUheGt8Sjmo8jPUdjxbyDqNjXxXHLTHwjhDUXhPMGgmej9a+KLkzCPrUsBrEfe6+cPlXcLcCQKxDjJtSeochQ1rW3JzEQ+yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1fK+JId; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-518799f2828so114981e0c.0;
        Wed, 05 Feb 2025 13:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738790054; x=1739394854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Atkob+jpFe5XAV3H/mgAKiaXJzCzAm2xhYQkiL8EHq0=;
        b=k1fK+JIdLhnCCE3Kvmmq8zsNE4vboWZbFWLrCJCFfdslo418YUBJXyNvM+WLXzvtGF
         9zAHFmr8WvhL9tTPLa3eB4ftCYyzmZnvfl9Xx2U30WmbbM8R2d7y9pbMKxUg7GA3HTe3
         vcHAhDh7GWzy5073s0WpheeZkwouX6CwO7orHcdjFG2YjC2lcu/9Ev9eCGy7yQk8ZE9H
         IhPuFnMUTliBACpH9iQuImlowfm+BHWCs5SQJ4aFFyUW7F/SE8TMV+e14kf8EmRP2NPt
         IrDjrLzhjfpA7irraCoNqEoAk7ZS7M6jNOXoYwZGwtpUmAJGxCg0OSsg7skOWJW2NATZ
         f7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738790054; x=1739394854;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Atkob+jpFe5XAV3H/mgAKiaXJzCzAm2xhYQkiL8EHq0=;
        b=PPyQOjJyx0Q/jFmhDBM5F97RxL/KBDpemwvI0R+PkCln4Q4pKfreHk7aKqn1G4eP0A
         3XJMiZY48K0a+fY1KIoUCTz8zIU278JnrrSAQppC04RD9Ti2is7VbonrTuI5iypLu/un
         819l9vJAI1PgYYjVc9JV3beKBe/dJVNIeF2L4doTQrVsRlL9b7daFcrpqa+aTlBRqd5l
         zFDEalJiOTh2llIM2E96ZXVKuYjsc1J76rcHXqLAhwamkUR78p9YrOgMzkLT3m1wN9Uy
         zIUFo87gjkLG1TI+e23WLEzXX78X4EzVil2Y+iDm578gUzDGryADbZ1wjXKJCF11xXIu
         RYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqcDYVA18eeyA0F+mW9ci5w1lLgzxFK7c7Wpi61HE4FxRRcGIsxuAB4xWVgyec2Vu4eH587mx3RkXc@vger.kernel.org, AJvYcCVbLnbLN0V+keht+g4Flx6KrXLPAlv9XKJGA+ON7vd4SYyDKcFseMV33YOEm7y9YEHIl5WWGg3q@vger.kernel.org, AJvYcCWi3VlYVyBqN76UxEyPY3nO6P0SZ/rR5aL3RQ88+Ui6YjfHdl7yAR9JHnRzmKncp1OWIWA=@vger.kernel.org, AJvYcCWn/riV5acF52CATpKQHJzXGduUET31p/Es5wUym5ycY7YFwGLuPifXScubZID07/n520RubWOrS6Xg/DlYu77r@vger.kernel.org, AJvYcCXGFLtT/AejPsgnOyPDiOhkj9sv7cZU6iPI87hSxamUuPtuXE32EniAwR/b5Xoj85h9gOCXvLuKD2bqkk7c@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6OTjSmYMk6FuZUdCNHgZUPO5W5Yw3ZSo8sn7brUWkyIfI8bnS
	3cUsAzJNVM9QnaTUUwn6Y3fcIcPnsUNozBATSNAYtWTrk325xjxI
X-Gm-Gg: ASbGncuxm/hwAlOnnh15YwM2RJmLV3Pt1qCu2kluyFo1MBGBdYt8wcB/hGOrGHv0pcg
	UkLZhPI8x0co5FxAhrIYjEJBnv0QLu1+i1nPavFXQPBK+5lxcPqD5vNTOtFFCkTTnedfjHN0SVI
	OutLKAym26gVX5K/3G9Iw45Hy2fMd4ZubTw/IBueTotUhnLcnHdanZc2ilysgsyuN64PF66/5Am
	z6ULJWxSqQsHrbuRLMG3nGXOfW54QtUiUwwc7LYCsQZz8BFi9aGFOmUdcNeGiKo31rq4qif/8RS
	/J8pVY+fziyaYVaChFBUnps53wafyFR8xST2w+mU4NGuF1gcw7DunoZQ4C6R6Qs=
X-Google-Smtp-Source: AGHT+IEfZi+/l4M87UPw5/vyc7KRKZkS3vvwSExWhswz2jpE396W7WJFjzoCPLOYlEnFqXotGyeJHQ==
X-Received: by 2002:a05:6122:1b0e:b0:50d:39aa:7881 with SMTP id 71dfb90a1353d-51f1b96557emr632876e0c.0.1738790053731;
        Wed, 05 Feb 2025 13:14:13 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51eb1be86fasm1914516e0c.3.2025.02.05.13.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:14:13 -0800 (PST)
Date: Wed, 05 Feb 2025 16:14:12 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <67a3d4a47801f_170d392943c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250205-tun-v5-7-15d0b32e87fa@daynix.com>
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
 <20250205-tun-v5-7-15d0b32e87fa@daynix.com>
Subject: Re: [PATCH net-next v5 7/7] tap: Use tun's vnet-related code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> tun and tap implements the same vnet-related features so reuse the code.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

