Return-Path: <linux-kselftest+bounces-16205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8EE95DD13
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Aug 2024 10:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0224282E58
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Aug 2024 08:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D19154C12;
	Sat, 24 Aug 2024 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="inNO3Ie8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7541C64A
	for <linux-kselftest@vger.kernel.org>; Sat, 24 Aug 2024 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724489730; cv=none; b=ISJ0bvV/omgMcHatKlmqmvwnn5nz/Cf7SSTiJ1iOY+nNWjomixwNIYLQ0DT5fYzT/pRGOQc8TTexVFLnIF8T4MPoVG2T21Rv1z79f+nJ8Ue/QkgdSynLj+dbWNO8quWq0So6puTBu8TkpjGPyLBlMcS8+FAcQNLF1D0kdD6wfMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724489730; c=relaxed/simple;
	bh=gOYIO37ACQYNQDZkx5KGsQM293glOt31TfsPyhtRVLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcAgPBkIl9mV8Gpas7OUWg887pnOGGmba9EBrJl5s861Hvn14uBVHN5scv8X/quV6Tm87vBhxreUgnVwF3HOtSjb3WV57TyimZ8g993jJ3MaDWV+b9h0NBKA0qAp/bNVUJqynKJmEtInDnndsP7Yp5ZUFBNlzn/6M9LXa6Awj88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=inNO3Ie8; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a86883231b4so353943666b.3
        for <linux-kselftest@vger.kernel.org>; Sat, 24 Aug 2024 01:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724489726; x=1725094526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOYIO37ACQYNQDZkx5KGsQM293glOt31TfsPyhtRVLE=;
        b=inNO3Ie8ew9NqgcBqVQNteYqxZBNcjIyQdSsTqzXCWO1/8P1zEyW3HUZXUvBgUbZG6
         IabqVCHgP5zCJbG7EQtJ+py5T8vy2dt1Ce2FBJCQZn4ULwwwNoZWSL3Eb6X81P2JFgLQ
         prXqHyYp/8sqBHOgoNsJqwpsFKr5wqxwwFWC5UVX2T3CQ4/DiYOZhOmDeru/bRGZz3Y+
         PHPvNzrpOEuTfypSwx63dnqXfKko1JYoreeViwSAbzGMeSom3mdzwgZ5ata7zZSJr4sC
         0ICK8ADZ1Ke1yG039kEZtl9nBkLhtYysDpenb+ZEJdgxXZe6etXC9YoNE6JuNqxf9mY6
         7y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724489726; x=1725094526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOYIO37ACQYNQDZkx5KGsQM293glOt31TfsPyhtRVLE=;
        b=NKaddFY5CyzpsEX3papsk8zv44drtblJujQ0APb/5y2/KLZD0o753IfdKSg/1Nl2pu
         ZdJCopqy5eG86GdZTusxvW18wrE9YlgXm+u2gEjZvK+7KpTGsTzAc1nJuuXVFAPLoUvC
         UMqZqAmnp3tedH56WafFZAjUEzBqi9eFcOUBdHWmfg/b3rnb0JLETYx3v7zu/AjdwXv2
         3N5yqqJhLYeoVrqDjJ4cMlOicyOGAV3NE9u7lCJ+eUJ4PlqYTrwpRZ/34b8nk+nI+gCN
         RekbG98xkaiRoxuQKzVtX6+jXVSfnSugxt314a1Fa7xsWWs+ycK4Bm8f/gQ3sNKUpPE1
         mCSg==
X-Forwarded-Encrypted: i=1; AJvYcCVUd8AlSr5QOLrfdVxuPxQyCVGJBFRND25aFRpZNIMUHq72RTjW4YmSnSXysLTKVVE5BnPmp6DUXLv0bM2WQ10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymg77wuEhoD6DiqBM6gdag6PwyjLHxQlNTGkoS4bmc113A4fZ/
	hna9y1x7rQf+ui06dyZhRyu3HoIescibVbuXH6Yoh+NHgObFS5mvM4cIsFbV4K6u/o5vo1T96j3
	Su17VyAFNNwUgLxrpQG+vtJgOMoy/Nb8PI6Ws7elDIEgLMfTwOA==
X-Google-Smtp-Source: AGHT+IEXKYS3mh8V/QCvTHnEuIp2hTfF4pSOwq4qmHfbzHN75ZZT/pLMTw06iM6ESCWMn9myppSvlL2hCh2bIbLrG0M=
X-Received: by 2002:a17:907:94c2:b0:a86:6968:3b93 with SMTP id
 a640c23a62f3a-a86a52cc30bmr283151766b.33.1724489724964; Sat, 24 Aug 2024
 01:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823211902.143210-1-jmaloy@redhat.com> <20240823211902.143210-2-jmaloy@redhat.com>
In-Reply-To: <20240823211902.143210-2-jmaloy@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 24 Aug 2024 10:55:12 +0200
Message-ID: <CANn89iJHPN_DfyMOGUT1OYQWD4S0bz6yjDcyMnDKb-fw_=YkKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] tcp: add SO_PEEK_OFF socket option tor TCPv6
To: jmaloy@redhat.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com, 
	lvivier@redhat.com, dgibson@redhat.com, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 11:19=E2=80=AFPM <jmaloy@redhat.com> wrote:
>
> From: Jon Maloy <jmaloy@redhat.com>
>
> When we added the SO_PEEK_OFF socket option to TCP we forgot
> to add it even for TCP on IPv6.
>
> We do that here.
>
> Fixes: 05ea491641d3 ("tcp: add support for SO_PEEK_OFF socket option")
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> Tested-by: Stefano Brivio <sbrivio@redhat.com>
> Signed-off-by: Jon Maloy <jmaloy@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

