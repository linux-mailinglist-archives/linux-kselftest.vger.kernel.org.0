Return-Path: <linux-kselftest+bounces-48127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92407CF0CC2
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 11:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D351300941F
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 10:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C08226CF1;
	Sun,  4 Jan 2026 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVS7uaJZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAD816DC28
	for <linux-kselftest@vger.kernel.org>; Sun,  4 Jan 2026 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767520828; cv=none; b=DOh+AqsN2ZcZtTVnCdpEvgowmwY7NnDhfyCjRI341Tn51LMeneQ/maDjFXmyDOn0aj5TP5zkzDkzJx9zQbKZS0MXvKN9NTUdbMU2vX8pIJHIoAzwJ1h3BvTY+hmISA17zgdJyV208eCObFl76V1OiDx/sWWvreoUU6i36M3ZuJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767520828; c=relaxed/simple;
	bh=hm2Vu6mwK8ose4vlTQrhJAECyIb3UrX+nklaehpSdnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJUSNlpDYZQpRmVkT/EGACPxi6YTzR5zVgmyr9pJaWM0VqQQxNZyMfUun+apBe+qluXMCkpRm4084Z2fIMLovo+vjf024xEAZ+PoBsKvMsik4HCitxXFkH4532w+QI/0mmYH5I9CjLmbWUHBUNV3PgfMp22JHynzoSZ4DCsnuvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVS7uaJZ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88a37cb5afdso12976826d6.0
        for <linux-kselftest@vger.kernel.org>; Sun, 04 Jan 2026 02:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767520826; x=1768125626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXIS1FlRa7m6sjrl4aOMyrl1r1tGaaVPP5A/N8Whrjs=;
        b=hVS7uaJZIbvIPhwEl2A8/DedVWlZyX5bTjAXmnnZhXc2/6NzURnh0qESW1bpdTq4d3
         gK/v4a7+xBC/nNssx8MvbGJgrIWBbypzc4gi6Ngjw7nMl9TGGDkSnDjzELPMlRnBPQon
         tfU2ujCTIrQ3E6J8rQfEJ2ZDvCagqHaKekgUwr+r6njq9KzKPKVBIIkbOIDTUUrFtEH5
         4sEdbr/pX/NsCYSVtjD3KaLJg1mclOmsUoBiTYrjxC0GV8hrISnWEV0O8Grp2/48Z3S2
         1wS6t7CW4vQ1m5SOPwgPvB+ZbQLwMGJNCKoZEJ2rfAwYtQW/k/yQt0KGq4pS7qSQBHg4
         d5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767520826; x=1768125626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TXIS1FlRa7m6sjrl4aOMyrl1r1tGaaVPP5A/N8Whrjs=;
        b=HqoEL4R6gsRCwK0tt9aIWbXX6eWCiZjEpRIakX4M43j2BhduvsF4rmTP45MrJo7BUw
         7TOWiu8OFEqeA1uzM1cf9D0kumk0kXt1gcduAeXE5W7WTBSTxkbcobqO+fSSR1PIf9OE
         qie7s/4usziWSKycojY469CrrH8Iz2Xg6sUR/V7kcfSMowgLxl8xlv0z1pA7WDFOfau+
         Qbi7tBL4m0LZFr+AWSUEFqqRTnPKsWxKMLtM00j7e3sOqTWfCdoywtYEIgj/Ns0eFfGn
         gZn0TUWwjHz34cnrJwBxK3euflfXhtwSEk+PCqnhtpw/tw6z/SaZOkMW8oGH0eCI+U7A
         VNsg==
X-Forwarded-Encrypted: i=1; AJvYcCVQlkqCBR1VUl1qtksMw/84NEILUBZGrybVRY2/j5fSyf/Y3KqsZNhudIXaF8SM7j9EO+v1EhjltzLk5/5BzG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxluuRfB4sQzY08L/gQopIDGbFCu8gdp9o+2PT6kbJYlsq3fk1u
	1KJmYuDw98oFzEMgO6tTpD2OeNMu1XU90Xcwjr6li1eTuVyhTyMLLp6p
X-Gm-Gg: AY/fxX7ADlkszI3X420TGulA58Az1awlzrU18+FQkFMSxQoxoHU2HnuQQAiOkkSK36u
	73K81XXpBe9dcplNv/XBdpsfV0jIT9glyVAs4d8dXZeESAsytRtrpERUe2ieWfCv/anSpBwdZAJ
	sYPnNfU+KbWL76rw/rXfjmdg/wvtHjnuXZl1SaS1pBpzH/hk72vcdfmjdw9UY7MBYXWP2zg2kaT
	eeCB/nmL5lhncBZQKndJKjenJG7ck70O+o3ZWxnvxCVpfk87jBEzO9sKV+pohfv0ka/p9hOMD8N
	uhokmOqW3KEUFTRmc1yrx9IinxT3rci+Z8Kt3jY9t1tMCGxORLSglwCgNIocnXrx9gwL2gsyYSR
	pSptAQgLtqKXa/pnFWg5g9lsxCtDql3JRogI8EzOD7wLkJ2TKj2/LE5QSo1NaCoTgv+OzLuy6+Y
	yrFrFqiakzNJchWl9t3JPwEPl9ie7Tt2RMpe8b8U4R28K3wYjfpNT7mz2+hfA3NE8mMUkGyiXl5
	OrYJUiLeK/fNJ8=
X-Google-Smtp-Source: AGHT+IHJXK2R3WeiJJDevqNrbsHSETT3xDVTi+xQ7Wr58QUWUx24qWhAB1reKUvIp+0KiJ3U34Vsew==
X-Received: by 2002:a05:6214:d0a:b0:88a:2867:981f with SMTP id 6a1803df08f44-890594fd07emr68826226d6.13.1767520825735;
        Sun, 04 Jan 2026 02:00:25 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9aa363e3sm329190836d6.57.2026.01.04.02.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 02:00:24 -0800 (PST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id C6FCCF4006A;
	Sun,  4 Jan 2026 05:00:23 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 04 Jan 2026 05:00:23 -0500
X-ME-Sender: <xms:NzpaafCsE4OSVqTp0gAwqxPrnR2Y0EgXSaB77iVC2eoZCSPktsgMuw>
    <xme:NzpaaWfAOEZ_Be3GyqqWz0ipj9WXKOVeG6ZePmaGceIPPk_PzFSWXlRhGuVDaEdLZ
    D3SGZd1Bb4J-hxgH9iuno7gT8Bk1-sXQi_l8aeKB86URvJrhAjeZg>
X-ME-Received: <xmr:Nzpaaa57p3LVRZm8ilDTBDVFEcEfYVE1cvLWC8_ZflP6CqO9VZnS-bSS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelgedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepjhhovghlrghgnhgvlhhfsehnvhhiughirgdrtghomhdprhgtphhtthhopehprg
    hulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohhsthgvughtsehgohho
    ughmihhsrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    nhgvvghrrghjrdhuphgrughhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    hoshhhsehjohhshhhtrhhiphhlvghtthdrohhrghdprhgtphhtthhopehurhgviihkihes
    ghhmrghilhdrtghomhdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhsse
    gvfhhfihgtihhoshdrtghomh
X-ME-Proxy: <xmx:NzpaaQPHV-DEIWPJbRFcA3LfJNZ_JVixhfUFM3iyWJSj8CmKaLw3RA>
    <xmx:NzpaabEQ5ixKJrC9oiUV5mwMNca-T1fwZ1nm2KcbACfsJtOKutlJrA>
    <xmx:NzpaaUTgZPtN68zdx1eNT9g0kH6Wo-6n9epLQpJf_vjqeo23ev4QPw>
    <xmx:NzpaaTQxAiUw7uKpbqpm2Tcq7jOVaQOEjvY4mNz9aqVkM4lFW1NHmw>
    <xmx:NzpaafeDuVCrHAyCG47hrAWmVKuHyyL3wyPBroe6eJkpvefHuEV5Em79>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jan 2026 05:00:23 -0500 (EST)
Date: Sun, 4 Jan 2026 18:00:21 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	rcu@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Yao Kai <yaokai34@huawei.com>, Tengda Wu <wutengda2@huawei.com>
Subject: Re: [PATCH -next 1/8] rcu: Fix rcu_read_unlock() deadloop due to
 softirq
Message-ID: <aVo6NRYDhxlMUANZ@tardis-2.local>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
 <20260101163417.1065705-2-joelagnelf@nvidia.com>
 <20260102122807.7025fc87@gandalf.local.home>
 <20260102123009.453dfb90@gandalf.local.home>
 <68b5b122-036b-475a-85bb-e39830f99fbe@paulmck-laptop>
 <252063db-ec72-42df-b9e0-b8dc0aa6bef9@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <252063db-ec72-42df-b9e0-b8dc0aa6bef9@nvidia.com>

On Fri, Jan 02, 2026 at 07:41:38PM -0500, Joel Fernandes wrote:
> 
> 
> On 1/2/2026 2:51 PM, Paul E. McKenney wrote:
> > On Fri, Jan 02, 2026 at 12:30:09PM -0500, Steven Rostedt wrote:
> >> On Fri, 2 Jan 2026 12:28:07 -0500
> >> Steven Rostedt <rostedt@goodmis.org> wrote:
> >>
> >>> Stacktrace should have recursion protection too.
> >>>
> >>> Can you try this patch to see if it would have fixed the problem too?
> >>
> >> As I believe the recursion protection should be in the tracing
> >> infrastructure more than in RCU. As RCU is used as an active participant in
> >> the kernel whereas tracing is supposed to be only an observer.
> >>
> >> If tracing is the culprit, it should be the one that is fixed.
> > 
> > Makes sense to me!  But then it would...  ;-)
> > 
> Could we fix it in both? (RCU and tracing). The patch just adds 3 more net lines
> to RCU code. It'd be good to have a guard rail against softirq recursion in RCU
> read unlock path, as much as the existing guard rail we already have with
> irq_work? After all, both paths attempt to do deferred work when it is safer to
> do so.
> 

Agreed. First it's crucial that RCU itself can prevent indefinitely
entering rcu_read_unlock_special(), because although unlikely, any RCU
reader in raise_softirq_irqoff() would cause a similar infinite loop.
Second, with solely the tracing fix, there still exists a call chain:

	rcu_read_unlock_special():
	  raise_softirq_irqoff():
	    trace_softirq_raise():
	      rcu_read_unlock_special():
	        raise_softirq_irqoff():
		  trace_softirq_raise(); // <- recursion ends here

while with the RCU fix added, the call chain ends at the second
rcu_read_unlock_special():

	rcu_read_unlock_special():
	  raise_softirq_irqoff():
	    trace_softirq_raise():
	      rcu_read_unlock_special(); // <- recursion ends here

which would slightly improve the performance becasue of fewer calls.

I'm going to include this into the RCU PR for 7.0 if no one objects.
Thanks!

Regards,
Boqun

> Yao, if you could test Steve's patch and reply whether it fixes it too?
> 
> thanks,
> 
>  - Joel
> 
> 
> 
> 

