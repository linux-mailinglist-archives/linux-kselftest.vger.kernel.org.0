Return-Path: <linux-kselftest+bounces-49428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF29D3BCE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 02:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68A7630341C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 01:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D754B14F112;
	Tue, 20 Jan 2026 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="caylSLYJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tQzKPjYp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E98176FB1
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768872747; cv=pass; b=vBa0Mqv7UIbI9IDx/BZE4hOQEGnkSWNljcuG3eKk4BGGMl+sBkwB7XDVNUXOkDmZc5SZiSf4PMUGPT3cux0lj01Hh/mCVZeyOpWiwGa4COat6dKizKoj5JHz695XJQIlVWueDvfRbQE7ot3p3R35ZG5zNptM7LcAy3hSQiCWjGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768872747; c=relaxed/simple;
	bh=HS+rs2sRhBDDAMedphcl8vavi4OEyMHPXceb2z5fJW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ug4Ae7Ea44d0orxWggAGiFml1BsZousJp7STs0NZQUXKXeGZIlnmUAer3iRyHAzWMu5OXnsPfiqzD9B35H923/Li0fNB3pugBnsHQAlxDUf5kZEjonT3e3nvjAxsxiZMhrCDcwv/VNU6cAKIvH+elJ6zY0YBqP3yb9JGQEEs+ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=caylSLYJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tQzKPjYp; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768872745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OsxU+JtWzgcHQNbkx+AZGIiB9jQi2bSbySQh+gDEg7c=;
	b=caylSLYJMjZOyQTUq+Ul+xC7s9qtseVsztSIRJOVAekSkZJ791Xb5FfUSjPHO+3A6bYbba
	c45kuJrjn5bgz7iUWY4HkKDuqqut8ETrPcYautfLXyf/z+MT4tKgUfO5SgpNmsIgdamE6T
	0/FLeOY+LsvuG1nqyIojsybT5oqxUhA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-OFfn5kitN6Ov_xqhzUCkgQ-1; Mon, 19 Jan 2026 20:32:23 -0500
X-MC-Unique: OFfn5kitN6Ov_xqhzUCkgQ-1
X-Mimecast-MFC-AGG-ID: OFfn5kitN6Ov_xqhzUCkgQ_1768872743
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b876b03afc5so1110376966b.3
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 17:32:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768872743; cv=none;
        d=google.com; s=arc-20240605;
        b=TB/cSiqVBW2JQWcbs8wHefb7Ie689eKGJ5V68NaHn0lDa1zuP1IOZ8xeflW2sDI3Dl
         BNkAG2YejuFTnB6c15wYE0Dp1PZSkXIr+LB5M981H+pEY6UySBeiBjeesD2Qouk17PjZ
         4iRLgE8kT8kX6Wkr1SixOTP1DnrC95YlXyIkXTkHGb/dttgbIJq/GQ5aGrb2Z5peWj6A
         VGE08cM1Tv4kjYAXle63g3/RYR/ltWTPtdKg8OMb74CboFhA0bIF/Vlk/6KE5ySlMiBN
         xba+9sEb/4d91OPFZfhl0t9qFq0pbVB+yE4brSqkFH6IJY0FXsQcRoSaRh/tzjYgeqdi
         3WQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OsxU+JtWzgcHQNbkx+AZGIiB9jQi2bSbySQh+gDEg7c=;
        fh=lkhiAi7ScY444NUDDlV9jUSSDPPoKoK+9l8i0BftVbg=;
        b=WFxvXTJQeOxKwEn8ANUzx6ItN/5qROjdBX2SspZuAWVuJJuQ6nFAhIn5qU33YVSkK+
         H3UO66TvQfVYKRDjkuneJa7YcliRj0rafpcjgZ3lrRwis+nzvzKzsLtFGEWzOX6GoyLR
         9j6TAJSLAO8h/RuoFAns31i/ucXqbAomW2axiostmpP3o4/pt3wmfRTSI1saVrQS4qW2
         UbyWZN8ia9S3vCbhuPXhequCVu3NcsytZuGkVFQyunnvawHpkyhW/GNs919lzhhKRH50
         EMLOpWJyAToy0dLKm/KMa9KczF/oqdqpC5NBHVD1j2StkZXDyjuzP0i6jnNyaCZjk+iQ
         iEiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768872743; x=1769477543; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OsxU+JtWzgcHQNbkx+AZGIiB9jQi2bSbySQh+gDEg7c=;
        b=tQzKPjYpsR9+36nkENpsNQmsZc82cmKfJ/z8Q1i6uKH2koSfnIBbtZ0YyZixt4Rpoq
         siS1UGiNMvwSjWNTxZ7ThTdNRDo3vZYfk66r4M11qKR6grhEheL086lGyMePMgLFG8Lk
         JAIUhMf/CbkHgWdwOTfSYkdNjDTdrx5UdIu2e7peP/C4nuvSEWh5J/dFs29UBN18IHv7
         qUWtHlyAspuf8rBUpfschLay7qJ73cIQCec8KGoalExRb/uhZEkwdz6JNsdrzliEBT7o
         hXLwfA6LsA4gUoIE0HFy/R/a7WGa9u8o0JZ9HkLnt8scfQ+S40Gh0TZSh18GDrKVIW8M
         Y4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768872743; x=1769477543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsxU+JtWzgcHQNbkx+AZGIiB9jQi2bSbySQh+gDEg7c=;
        b=Im/NP/A4/d3Xjq5gRUq6XKXXlhNIQkqQf5/LDNMcK8i5iUIeyDOUdrIIwpfTERYjqX
         HnMsMfOB4VrRLeqnbru2e9O8zX6LKazVh/+AKimwcfMUlpZ2ynsgPLiLb9/In5Q8zy29
         CIM/1c7N6QcG99nWdZvEt1RykPlwv0m8kSj8Xw5qFhIzjEs8Rm2EVToZH4sQ0r6OBXVR
         uklc0qWZGlg8xsVPqYqYzp3RIhINuDLst6cbROtii4nJKBlSiopEc9jm3KEsq5SYllP1
         T6xFGM8wcyCoPa6Cr0rTSc6F5bXe3uH/BmOGsYXnKJccbDCMazaynvQHreJSZNamMM1R
         feWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz0a1IvFg/WBVNpcr51xqXmahJ+r3hJBeZljKPB1qvU9iEFsXb1XcBEuWyetgUB7HV1QrM7U7CNjUebaf/+uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ9sI8gFm7bK6lsvk+bRQ957d2/imQpY+adXFOtDCrz11mkGhd
	GKdBdtu9QLHtGwnVTR9atIbKu5amzDtI0vo+H1KItd7wEn018Hude160dCk1dOgNb1JMWPCKs2/
	bqKz0Z0FIZXVHx/lLjnbRzIXzsa/2BYCF7NOEV1FQxgrDcDI5Bht5Jcr1ah1Bjdv5TledfI/PoK
	Vt8Sub7w4SAOWW0ImlTh1tIuwGkqqPZetdUXyd2julKIAq
X-Gm-Gg: AY/fxX4XR+F/59uNPW8JwTgFVqdo144UOmH802spZ62ou8gFzNXlS1ilauHscrg6VTO
	AsswPNOc7459RbsPM9ZcMO11ucxtP947j9CbLzhCpV9werIlidScL961uJG+L9SYebgYs68v4XV
	B8QJIqel8JqdbGHdcslAEDKfM+121y7bX3XLjpHNg1UebUsjICfya0fyDpVL1je8SOp2k=
X-Received: by 2002:a17:906:fe09:b0:b86:f558:ecad with SMTP id a640c23a62f3a-b8800236e57mr18222866b.7.1768872742768;
        Mon, 19 Jan 2026 17:32:22 -0800 (PST)
X-Received: by 2002:a17:906:fe09:b0:b86:f558:ecad with SMTP id
 a640c23a62f3a-b8800236e57mr18221166b.7.1768872742431; Mon, 19 Jan 2026
 17:32:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768800198.git.xudu@redhat.com> <58c5767a8a82352fb784d8d51ec844055b6d7ff2.1768800198.git.xudu@redhat.com>
 <20260119090916.1fe303a4@kernel.org>
In-Reply-To: <20260119090916.1fe303a4@kernel.org>
From: Xu Du <xudu@redhat.com>
Date: Tue, 20 Jan 2026 09:32:10 +0800
X-Gm-Features: AZwV_Qhnz65hOYE219XnOZAeK22v2xydMZgt7mHbCC49P7QqnmBYSPK55kXyaOU
Message-ID: <CAA92Kx=BFz4FnMRUQYYtWnBjwHEKExVuviA8bWMcfBi6=Tonww@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/7] selftest: tun: Refactor tun_delete to use tuntap_helpers
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

 Thanks for the guidance. I will work on resolving this issue.

-- 


Regards,

Xu


--

Xu Du

Quality Engineer, RHEL Network QE

Raycom, Beijing, China


