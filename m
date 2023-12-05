Return-Path: <linux-kselftest+bounces-1211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E58805EE3
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 20:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39581C20FAE
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 19:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43A06ABB2;
	Tue,  5 Dec 2023 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXVA6F5K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1521A3;
	Tue,  5 Dec 2023 11:55:51 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35d77fb7d94so6765345ab.0;
        Tue, 05 Dec 2023 11:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701806150; x=1702410950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myAhoAL3FsWsxkQ1Fo/Fp0yF5gBJWm/J11tgIt7SwS0=;
        b=NXVA6F5Kq8iECdIz8ih3eJGJUTdOZTnyAaKmsyK3IPpVx8kPPG77luSn7lf+DrKt9r
         /McQmekR+g4iA+CakdT+Zu496nVaIGDIJFqG1DYpJbCVYytQ7FsV3a7eZrOVg2aJrlav
         E6gNLl7zy/Jh+PiCvFs47OYCvw8JXAlPxdsQaIPGHOk37VOWjfJOwQAXdIBnHBEgZikL
         IJQI5ji7G7EeGGZdJX6S8vTHTq4KXQuvkQUFtKIsQVajaXqNw/xS9NakipCfMC2OM+Ri
         W4Sx9+9O8yp181bj0mXqhOKiI8djPCpFG0MzQVhJnuDIiDlhdUjmhRLMQNDO64wSgqzx
         ZCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701806150; x=1702410950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myAhoAL3FsWsxkQ1Fo/Fp0yF5gBJWm/J11tgIt7SwS0=;
        b=LXpDUdvKMLgdOnZtRfj/HK1HArAtwA/72B7YVkmS6TGvp+DT9SYUem9H0uz/Tmb3F+
         rEf/cAUPwYUg3H+49Z0Lt7NpKwagWKwes/FDiXBJ4VGYq8f5jFjQ1x4G7QjNVK9Z0W3/
         +qyXbzUKrVk6hWYyyDFeMDgnrwDNXM4j5CLM0uhGCbixvQom3fMqZNmRda3yoJObqxAX
         zoDfhkMD0vYmRJp3rUJuDauJDbgFt+i2Q3xn7RtFbMhEox8Ldymx91mmyiBATMGFnSdP
         v9+v+Iy6e9dcnW8E12fMyvUsplJImkd0ge03tkURWUVSduu9+AlE4xeSbQO9k4PKnUcl
         dfVw==
X-Gm-Message-State: AOJu0Yz/U7nwlW7+zz9lxGMbZ/RubfMwaEyhHhpcBbS35jGyEE4vV/lp
	iCp7pGr6bfs3f69mfBDEl8NjHIOHUgfL/tAm90M=
X-Google-Smtp-Source: AGHT+IEIJimYnDks1iX4mpQMgslZjhDby25uudRaA2OQ2jItRpcRf05zbeSE0yU6CQvYUIc8pQiJmt3Wi7BmG9YEIvE=
X-Received: by 2002:a05:6e02:1d18:b0:35d:6c9d:c339 with SMTP id
 i24-20020a056e021d1800b0035d6c9dc339mr5624662ila.65.1701806150474; Tue, 05
 Dec 2023 11:55:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-3-nphamcs@gmail.com>
 <CAJD7tka+e-RWVN8qkCLv52z8G0KAXNO87CqV3p5Wgkx6BvneLw@mail.gmail.com>
In-Reply-To: <CAJD7tka+e-RWVN8qkCLv52z8G0KAXNO87CqV3p5Wgkx6BvneLw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 5 Dec 2023 11:55:39 -0800
Message-ID: <CAKEwX=MEJyX=Mavk3wRr3k4pTxsVrbwv3FJL2MPQVJ=3AgM35g@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] memcontrol: implement mem_cgroup_tryget_online()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, cerasuolodomenico@gmail.com, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com, 
	muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 10:03=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, Nov 30, 2023 at 11:40=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> >
> > This patch implements a helper function that try to get a reference to
> > an memcg's css, as well as checking if it is online. This new function
> > is almost exactly the same as the existing mem_cgroup_tryget(), except
> > for the onlineness check. In the !CONFIG_MEMCG case, it always returns
> > true, analogous to mem_cgroup_tryget(). This is useful for e.g to the
> > new zswap writeback scheme, where we need to select the next online
> > memcg as a candidate for the global limit reclaim.
> >
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

Thanks for the review, Yosry :) Really appreciate the effort and your
comments so far.

>
> > ---
> >  include/linux/memcontrol.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 7bdcf3020d7a..2bd7d14ace78 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -821,6 +821,11 @@ static inline bool mem_cgroup_tryget(struct mem_cg=
roup *memcg)
> >         return !memcg || css_tryget(&memcg->css);
> >  }
> >
> > +static inline bool mem_cgroup_tryget_online(struct mem_cgroup *memcg)
> > +{
> > +       return !memcg || css_tryget_online(&memcg->css);
> > +}
> > +
> >  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
> >  {
> >         if (memcg)
> > @@ -1349,6 +1354,11 @@ static inline bool mem_cgroup_tryget(struct mem_=
cgroup *memcg)
> >         return true;
> >  }
> >
> > +static inline bool mem_cgroup_tryget_online(struct mem_cgroup *memcg)
> > +{
> > +       return true;
> > +}
> > +
> >  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
> >  {
> >  }
> > --
> > 2.34.1

