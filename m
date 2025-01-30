Return-Path: <linux-kselftest+bounces-25426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61611A230D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 16:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25211888C9F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 15:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F22A1E9B19;
	Thu, 30 Jan 2025 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsu1fFn8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D611E2853;
	Thu, 30 Jan 2025 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738249607; cv=none; b=nOg/nJ+v2fH2RpiM2ZWkJqjdT9oblScuUCAlcX+It3HAKfssdxaUf8czVqv0rqX+gf9dOsrZEpETtSYlgYmlydFYp7F7LVzD+lNj0sCzywaR4vC84si9cBql8ys8W1lurYP7/Oa6D1ClzH5MCKqeooNzpYVPBx40PIv7lLamPsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738249607; c=relaxed/simple;
	bh=lPHx7WaZsUhvB70yZzHrPTeASZHFEDazFq/DwQM9k+c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jSq7IG/CK4IOPTTnVVdAplj/XvltAaDR7UzBIbxeKhmr66irR/EHXpnhEPCz6sZJChq9+4OOiuM0yRUL0kKZZ06AjP9G9thUHucvS0buqvAgowsE+WID1ez7wYyqa7j5yYHUyFSx9pAjaKhHOGQG8F2qKj9z1f/V2fRc5agCYkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsu1fFn8; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7be44a90468so108970685a.3;
        Thu, 30 Jan 2025 07:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738249604; x=1738854404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JI5cvnHUtQaistWIrGNna3l1hMRw3Olm90CfuK7nl+8=;
        b=hsu1fFn8DWVYPCnfe5qorKaaPUsG9mbCqv0nVkUKd/QDYH0cumfWj6JxwJca6h3+0n
         XoOaaKWM76h7GjCuClOId43ka3zerqZHon99OKKpwp0DBxTsywPh+XPlzHTMe6Ao7eaG
         bHuoFZ0M7fxqmHrF7dbXYkL+F/ABYSAxtdOHLL/Q7srGZe49+DjNQLpqKvQcLX88O4n0
         xRlmUPfktHbpVQ4dlTCxaOHDFoTBIcvQgurx3sBadvB3taF9SZmKcsEkNruiv3oYV78E
         iNewFwwgOndNxiRNNcoOPN1fxT5ADGuU4NwEZK+Lerg8LLxRStvOFqHmjXofKjJKGjze
         KyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738249604; x=1738854404;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JI5cvnHUtQaistWIrGNna3l1hMRw3Olm90CfuK7nl+8=;
        b=Yp/WYeyOozKKryVUP8BB4MUJPY/ba3RU21eZTFnZqxoWw/mbpuEJcuYmCqjgKumOKS
         ZioZeirCfy/yolUZur2DgRuhwbYoliXkEyQVFRslU5z+3vmNjp6kcs9LbMgtzpgLcTno
         1N/aGkl/vjmg4FZQWxnlISghFiB0EcLi4+xnWIKEiL8h4jeDujcytppUl3PN7s1lgmY0
         wJJfkrjm5qQRXmsX+tD65315cNJHaTSAgSP/NRQ430VmzyU4NEOd9HoUZQje0EJ3Pugy
         uP4IClnD1H/TSekK2XLWtw8bY/bzwYhfRVb/aZvpi2K6I2+dRAAU8/CCX83jvs+l+7uL
         xfaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU66OUMf/HYFEBDIORqzsl8fp/+rwvLeEoMP3MPg4bfzdwFkmgbbQpG8to48cYtqj5ChCQSo9Gsp0cONpUZGbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlVJfmKHVSP4R1Gp65d7vQv7P281C66s82trriWtRcvTSFdyZa
	lvvjiz0fcc/ksXpPTydMCWg7Offw4bBSsduB+yRwYthsLCdRcnju
X-Gm-Gg: ASbGncv/wCHfQ78UXsO/9lMzGTgD73dCGBReqHtnDoC8vfP/ds1QFMGSd2DaMkKbgGb
	dQSabPRs8t0ye4vxewn8ETLBCp8Pwgeb9aRn3v6WdKreBBRB2EyiJQ1YBY4ADlD5cjc+JTcTzZf
	PNKqxmF6u/BL/H3oR0l9zi69gIYRLGLDWC+b2yOrX8rcvgyUBomyId3UMoFZBrI/qzIVtDbeBCp
	W8s44xbn2TJ6LSLTW3tvG7PDEnunmfYsa7O5LmSWJsY2+DUkjUxkl46l5F73RF3MV7yMagN9DlC
	ew2dWI20ca8rET2XruJr6kxKKfx1IJIcQmC+MWIK3gylFiwHZ66q0/LODj3q/gs=
X-Google-Smtp-Source: AGHT+IEhcvqek8X/10GXPUdrkYOae79A4soxEePRG/3Mi9gTYA5EN3/mO+so46rHgN3Bc8y1Vyihyw==
X-Received: by 2002:a05:620a:390e:b0:7b6:bbe8:7d6e with SMTP id af79cd13be357-7bffcd9b6c7mr1236325485a.40.1738249604189;
        Thu, 30 Jan 2025 07:06:44 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a905afdsm81570285a.81.2025.01.30.07.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 07:06:43 -0800 (PST)
Date: Thu, 30 Jan 2025 10:06:43 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Anna Emese Nyiri <annaemesenyiri@gmail.com>
Cc: netdev@vger.kernel.org, 
 fejes@inf.elte.hu, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 willemb@google.com, 
 idosch@idosch.org, 
 davem@davemloft.net, 
 horms@kernel.org, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <679b95838f17_1c77632944f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250129120526.7ba0958b@kernel.org>
References: <20250129143601.16035-1-annaemesenyiri@gmail.com>
 <20250129143601.16035-2-annaemesenyiri@gmail.com>
 <20250129120526.7ba0958b@kernel.org>
Subject: Re: [PATCH net-next 1/1] selftests: net: Add support for testing
 SO_RCVMARK and SO_RCVPRIORITY
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Wed, 29 Jan 2025 15:36:01 +0100 Anna Emese Nyiri wrote:
> > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> > index 73ee88d6b043..98f05473e672 100644
> > --- a/tools/testing/selftests/net/Makefile
> > +++ b/tools/testing/selftests/net/Makefile
> > @@ -33,6 +33,7 @@ TEST_PROGS += gro.sh
> >  TEST_PROGS += gre_gso.sh
> >  TEST_PROGS += cmsg_so_mark.sh
> >  TEST_PROGS += cmsg_so_priority.sh
> > +TEST_PROGS += test_so_rcv.sh
> 
> You need to add the C part to the TEST_GEN_PROGS, otherwise it won't
> get built. We're seeing:

and to .gitignore
 
> ./test_so_rcv.sh: line 25: ./so_rcv_listener: No such file or directory
> 
> in the CI.
> 
> > +	memset(&recv_addr, 0, sizeof(recv_addr));
> > +	recv_addr.sin_family = AF_INET;
> > +	recv_addr.sin_port = htons(atoi(opt.service));
> > +
> > +	if (inet_pton(AF_INET, opt.host, &recv_addr.sin_addr) <= 0) {
> > +		perror("Invalid address");
> > +		ret_value = -errno;
> > +		goto cleanup;
> > +	}
> 
> Any reason not to use getaddrinfo() ?
> 
> Otherwise LGTM, thanks for following up!
> -- 
> pw-bot: cr



