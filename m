Return-Path: <linux-kselftest+bounces-8626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8123A8AD01F
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 17:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A881C21BAA
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 15:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A49715250D;
	Mon, 22 Apr 2024 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uuWd4gh+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDB8152199
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798191; cv=none; b=psDB/p/pRLLAAgchwKw/1F4GptyDyjrvyqyo4D8FDSl0ADh0VieWxqV26UIArocyFaiyc1rx2DpTyo9sNDtWK+xAA99WGizNeNw0qCg+oDNWkWvb56AMyajOqCgtcC+xyKLGI+CEDkf9MqmWawZYX9vY5Slo3LYIHyNuHI7hCAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798191; c=relaxed/simple;
	bh=opHmyQIZVxOOADeZVoerlK0O/JczCZYTLh8nmMvSqis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBZKMH2Hobepqy1lvqj4Yq7ZnpAt8VNhAcYcpMNe+MjTsQLm3J6m1DSeV1IHbElmOlkhP+jBuqK0B1UZClqsK6EoClgLQL3BwIVGNtrwOngyYVPge2pzN3Ag6niHkAo1gmEs+uo/Aqxb3M+nWBlLL77i3LGOqq2rc0YLebgr1Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uuWd4gh+; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so18376a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 08:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713798188; x=1714402988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opHmyQIZVxOOADeZVoerlK0O/JczCZYTLh8nmMvSqis=;
        b=uuWd4gh+jJ7Xqff6I3+dvVCljG65Wgaa0q7rj6ATqGiYs+jv1ISoyWpTJgcz9a9Wc2
         SaJiNbIPgQGwpCWjLwm5zJk/Q7dJnH4+M0A5H+sINH6Nmqod8CD+07Ef4NpEAvNiGMyt
         oTSJSEXB/D2k18WmTeKc9c2diTyOCpEL/49gkXMlAOzBNy3fL8b9GzfD2LvoIM3rrSm9
         r528fnN5dNBuYfvlHrbJtscm2kzYjutXh1KhhrBu2PARdNXX6BKTQLf1gPV4TV3wsuya
         /dJjMlgk5rhvJ8zO/ImqY84JxTyIYnrixbn/BuQ/gnHQ9pzG6oDVUZynzCyo9y4xGtll
         CKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713798188; x=1714402988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opHmyQIZVxOOADeZVoerlK0O/JczCZYTLh8nmMvSqis=;
        b=bTvLD4u/6pN8YisZzeOYlJKZEMXEU5w+YH100soLvljHcjT1Ji1aMEzsBuRF0M7nh6
         3uUnJcNOaqW0/dAldKHaFc/Ceko7UpTe6F3PE85vwU2kOzH8wfBG5IodTSMJJVdStN1S
         ljP7ol+31oX21y2VZzi1ZQnCRxXCemaUrinIv+mcRe4W6GSlT6tS+H0OiOXkAweWJGkL
         J6Anz8rUd/mJyCCE9cZ3H1jM+RyOLL7P67QrO97Sb7rVq/Nf/SFAYBiQ9KPFzRHDKrB6
         C3Hz54rb3BqCkg3jFvHSlGliOF5WLf+cOTWMU32EYi+xl49FPEq3irg8KGVzuI3iu/b8
         rbJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOvF1/TcVFcsSN9CzoLz6utu/9A0oksScm9K3n8ad+bfbvnVv3KZbT7J5xezeBQpO2xbV4BM3sH+wdZoz7S94eDqRpJvcbAbZB7q0mVmem
X-Gm-Message-State: AOJu0Ywz8gL8Usij9YJCqIUvBwShhQ7BFpFn2zB+Aq/OxYxJQ1bXhPwS
	xMMmt2i3Wj/Z+OVOhDlYKOor//4KKNDvu32Xh4tj+wqdt/Z4QGHVe4vNZ1NhaOMkoMA7whjVfn0
	7zJ2njo+u7g+s+87TPrKQaxIpA4rPTUls7LZd
X-Google-Smtp-Source: AGHT+IGX9rDB+qbhFMyYIg42Ne/A/wJsJhw7qq+3UgN0ukHWp/zb3OivY031q1jupJvoDR13aA7ELdapUgRo+/Wwi9w=
X-Received: by 2002:a05:6402:4315:b0:571:b2c2:5c3e with SMTP id
 m21-20020a056402431500b00571b2c25c3emr293628edc.1.1713798188023; Mon, 22 Apr
 2024 08:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420023543.3300306-1-kuba@kernel.org> <20240420023543.3300306-2-kuba@kernel.org>
 <CANn89iK-wnNeH+9-Oe6xi9OjoY5jcZCowJ5wDL7hJz1tRhMfQQ@mail.gmail.com>
 <a1340c70-bbc9-4b23-8e9a-1bc401132721@kernel.org> <20240422064825.18850cc3@kernel.org>
In-Reply-To: <20240422064825.18850cc3@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Apr 2024 17:02:53 +0200
Message-ID: <CANn89iJOGunkDHFOHjZHQKm9aDJ1S2PWgiMb_FPfpWfiW7cfyA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] netdev: support dumping a single netdev in qstats
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, sdf@google.com, 
	amritha.nambiar@intel.com, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 3:48=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 21 Apr 2024 13:32:24 -0600 David Ahern wrote:
> > On 4/21/24 1:17 PM, Eric Dumazet wrote:
> > > I wonder if NLM_F_DUMP_FILTERED should not be reported to user space =
?
> >
> > good point. We do set that flag for other dumps when a filter has been
> > used to limit data returned.
>
> That flag appears to be a, hm, historic workaround?
> If I was to guess what the motivation was I'd say that it's because
> "old school netlink" didn't reject unknown attributes. And you wanted
> to know whether the kernel did the filtering or you have to filter
> again in user space? Am I close? :)
>
> The flag is mostly used in the IP stack, I'd rather try to deprecate
> it than propagate it to new genetlink families which do full input
> validation, rendering the flag 100% unnecessary.

SGTM

Reviewed-by: Eric Dumazet <edumazet@google.com>

