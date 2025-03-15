Return-Path: <linux-kselftest+bounces-29114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA184A622A7
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 01:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE3F176CE7
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 00:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07FE10F1;
	Sat, 15 Mar 2025 00:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdO7T1Oj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2401936D;
	Sat, 15 Mar 2025 00:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741997904; cv=none; b=fdrqUXVU2dUsHSznPaCdV/FpZVyVxpftXfM855D3CwNwNVAk+xy1azntM2rVog9/CNa9HPTpgOURJF/dmgJCqnrYtf3mzKJWYxwnmcetBml2azJMcIqnXuYGr0BkQyzti2rWqN1/KCA5C1Mj5d7qbBjKk3U70rCMUZQkY4X5w/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741997904; c=relaxed/simple;
	bh=g7N0/JCTS6OufAO4Kgybu5W7kXCd+wNIWPPOS/UbXwU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm0ceJCHH3ikE/AfVPFboWes51+wBIvJrKnYe5HT0xPI7OudxogMPM+x1pKVO2vJEczqmWDoLTcIhiCmRggn/C9F2u4yZYDImyxWmTwRkp6/Vma7OoQ3deAeicco7cllO65w+D5pkKKfKxvGjRGjp+wv9I+F17+WL05vYLsb10s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdO7T1Oj; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c542ffec37so271708685a.2;
        Fri, 14 Mar 2025 17:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741997902; x=1742602702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MW/Q581Re/FQqAaGAz+jf2rOlLwJG+NP8CU6/zqtpc4=;
        b=GdO7T1OjzsZnCsdfFUtWKvI9/LNYbdF93rZmXqJZpVhrtD9LZ21S+AllwQm/ohuwQS
         /L0mR40SclPErNtv9SvZNV+F8uwI+MRmqMt2ZDNjY2LNUafTatPRGAiO4cqE0mIW0Ldd
         DQeEc266WfdGf1N6eJ6UphjgXdaOYfDH36Rjk2vyYUUQnAkDthTBwHQtlXjTwYNlGPSE
         n/yeesuUzDUFe2KY3iJHgpvMeIkAY8ZPYyQhNlvgDCCGupzSzxe1wx3dtFxPKGF6ByEf
         QckeGMI5bizYVDNsdlJQyfAX4YggfznMvyl5Jfu9UAm+v10OHbk9NfurdiEInUbMezrj
         93PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741997902; x=1742602702;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MW/Q581Re/FQqAaGAz+jf2rOlLwJG+NP8CU6/zqtpc4=;
        b=SFdGp1aIOzpPxbzq688wsECtYat3vM8pdVuedruEfjGodNw5vy0ew+taNgqmIa9guA
         +2xcIckK221vdYUQ73fBdhAuUFygpUmC157fOEbhyy9bbd6ajS6gGi8Hw8QIftUU7tPW
         q9woLpGhfOhNSNmnBU4qtWGLm40qi0O3k9HzTAw+FO1bNcrNc443iPHv4edU8O0kJTuo
         BY5LvmxKzmKrjEu21SUQWllsR743fRC2qI+Eut/R006MRlxnn2Cir9Qu6An8qtNo+l1x
         GzdYbBCxWeYQymL7ygiJ1oiVyZXveAvdDxkXqguLe5kAIYZteQmNbFcv/xOUWTfsSwM1
         NFhA==
X-Forwarded-Encrypted: i=1; AJvYcCVEEUsUCcd2Mi/79fWJzl9kX2fXVwjTJONi6J7a1PfvbC5L7aCUbhbaahGhBUoXosHDYcHUpwqExI/RlA==@vger.kernel.org, AJvYcCVsaThx2nfmrGJt7PXJPO5tAytJe6nhVZEDkHthUUkZ/r8baEC0VhJ3vW8ePyLZAOyOmfuIMB6LuCUxCEOmSVk=@vger.kernel.org, AJvYcCWgUkaOQloo9Z7DapYzqdL+jssp3idU8ao+HY4lMwLOQkjJAVw89JeGJBUKfCbOCHQBuiv3aW4L97xs+rnv@vger.kernel.org, AJvYcCXEmOdTK09OwwKsyWmqIs7uF/8QBWALRtJ9yn59+juA5oa2Cv/BQlr3afhTvGWvPm02X5BV3cTq@vger.kernel.org, AJvYcCXc9Gvd+JnCE5EvFqjL9gD8JpSrM+/l/MaAE+caLlP2VRy/T9h0EUHKkiI+nD40Rrh4tAh2KrhGG025ocLpOU92@vger.kernel.org, AJvYcCXr205yrglrgebsJ3Y9iaaT0gQs9Wdpb4b4Q5O8hGx2uFGnKlhpTDczqJ6GNNv0NY5vY14dbjynG64Y@vger.kernel.org
X-Gm-Message-State: AOJu0YwP+rP6BA7+aakxNAnP7jBaP8+ZuPabEiGGa1Pz+brlHSN1EzGG
	NRHe2Z+4JGqXHgdSF7fvsmmszTYZMfpRUb4UO3LyPN8TBuD7hnMB
X-Gm-Gg: ASbGncvBcYVYUtE011lw8GeEdFTywhl8tO1g7Uhxbtib2Ds64kFio3WGV5hT/eBn1gT
	b4a3m5soJRTH1HCRII6yZBuwnFsw2PIQg4AUqYXWms5chCS5bDtHcglJLbybQVTXPp0MOx/0Pnn
	xBfI53j1bF9kvTz/zT3o5P7sw8cRf03v5wBgT85S4re/HPY/KeyKTxvmFGn4Bw0S2Wugql0Ljw7
	ckbaF7pSvZgE+xwFoZ0DBbPGV3/cs3MhhdHOdBGGFbFUQbqNoYu7v3z8p3600fHjt+Zykm4rmo3
	VpaVr8ozUOXt2R+HFOiA/i0eYG/Q4nVlaz8RcUqC6uUgy/JgJzdaWufcH82sWwbw7om707e5rdb
	6gg+KpzwdntL1/my8eyzQEgeZQ2rs55qowpHhn2RSsKcC2Q==
X-Google-Smtp-Source: AGHT+IEwyke4ZW6L+ZW3RCnZV78prYvLyXaehAEXAI6EbOZkgETy/Y95traqlk8pruRLBhO0X4DyAA==
X-Received: by 2002:a05:620a:3193:b0:7c5:5cc4:ca61 with SMTP id af79cd13be357-7c57c79bc00mr650619685a.12.1741997901820;
        Fri, 14 Mar 2025 17:18:21 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c4f53csm316677385a.22.2025.03.14.17.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 17:18:21 -0700 (PDT)
Message-ID: <67d4c74d.050a0220.66d0.b23d@mx.google.com>
X-Google-Original-Message-ID: <Z9THSUE08cLVCy84@winterfell.>
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 692F61200043;
	Fri, 14 Mar 2025 20:18:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 14 Mar 2025 20:18:20 -0400
X-ME-Sender: <xms:S8fUZ93vaXJHgA4i2OX5j7lqSUEMZSSO9FqzBdBhtRyWLxXVYVCsmw>
    <xme:S8fUZ0HLTfLNJiQeMU5I6MqZ8QPxOGPZjEbiLBTc00U_pJoJb74wL9HqKM2Ymoseo
    QJfsxTfTu-hLA_N2Q>
X-ME-Received: <xmr:S8fUZ95ICMUGXCYWQXMOcOfyhFgvt-wKrx0HdFdd-gHr2P4k5Sz2PT3dGEs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedvvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeelveeftdduudduudekudehtdevheduuedv
    vedtjefghffhvefgtefggedugeekjeenucffohhmrghinheprghspghpthhrrdhgrhhouh
    hppdgrshgpphhtrhdrphhiugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhith
    ihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgr
    ihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdehpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopegtohhnthgrtghtsegrnhhtohhnihhohhhitghk
    vgihrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgv
    gidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhi
    hguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhl
    rdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpd
    hrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    thhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:S8fUZ63miUs8A46sM87ugHi-Oyv5gDGAOeV2jp8WrX9Vhu4cAcu8og>
    <xmx:S8fUZwFqtvgMWQzw4nkYqCBH9hzZYEAbc02r9W5gKE7rZPxMu08RmA>
    <xmx:S8fUZ7-kuuBfRqtDRPk1VY26XFfYxB3Y68xUHg_yuDsT9QaXGIpoPA>
    <xmx:S8fUZ9lQLVRAlJ0sWQuVHZZlUZUZRYhswChrgXCMpPJsig0jRtoopw>
    <xmx:TMfUZ0Evq0x3ESylammkr00E6rkZlRYT26JN4xhqw84EzOt3FOQMe2uu>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 20:18:18 -0400 (EDT)
Date: Fri, 14 Mar 2025 17:18:17 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Antonio Hickey <contact@antoniohickey.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/3] rust: replace `addr_of[_mut]!` with `&raw [mut]`
References: <20250314234148.599196-1-contact@antoniohickey.com>
 <0100019597092d67-0da59c6d-9680-413f-bbce-109ef95724cc-000000@email.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0100019597092d67-0da59c6d-9680-413f-bbce-109ef95724cc-000000@email.amazonses.com>

On Fri, Mar 14, 2025 at 11:41:55PM +0000, Antonio Hickey wrote:
[...]
>      /// Recreates an [`Arc`] instance previously deconstructed via [`Arc::into_raw`].
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 49012e711942..b2ac768eed23 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -257,7 +257,7 @@ pub fn as_ptr(&self) -> *mut bindings::task_struct {
>      pub fn group_leader(&self) -> &Task {
>          // SAFETY: The group leader of a task never changes after initialization, so reading this
>          // field is not a data race.
> -        let ptr = unsafe { *ptr::addr_of!((*self.as_ptr()).group_leader) };
> +        let ptr = unsafe { *(&raw const (*self.as_ptr()).group_leader) };

This can be a

    let ptr = unsafe { (*self.as_ptr()).group_leader };

>  
>          // SAFETY: The lifetime of the returned task reference is tied to the lifetime of `self`,
>          // and given that a task has a reference to its group leader, we know it must be valid for
> @@ -269,7 +269,7 @@ pub fn group_leader(&self) -> &Task {
>      pub fn pid(&self) -> Pid {
>          // SAFETY: The pid of a task never changes after initialization, so reading this field is
>          // not a data race.
> -        unsafe { *ptr::addr_of!((*self.as_ptr()).pid) }
> +        unsafe { *(&raw const (*self.as_ptr()).pid) }

ditto:

    unsafe { (*self.as_ptr()).pid }

because `*self.as_ptr()` is a place expression and won't create
temporary references.

There are also a few clippy warnings, you can check them with CLIPPY=1.


Besides, it'll be easy to review if you can split the changes into
multiple patches. Thanks!

Regards,
Boqun
	
>      }
>  
>      /// Returns the UID of the given task.
[...]

