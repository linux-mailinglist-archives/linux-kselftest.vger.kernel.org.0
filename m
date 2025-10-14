Return-Path: <linux-kselftest+bounces-43128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64513BD9A58
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 15:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29F919A2FCD
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 13:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C0631352D;
	Tue, 14 Oct 2025 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gXjyZpFN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC804305958
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 13:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447357; cv=none; b=RmoZ3hjU/uiEYlLy2zyDgnLnZL1jiEMFHgiPpc1QLUYpUuekZXXcbwy2aX5OYv1utgrpRrinRXoh4qCMjwXELPtKTFZLnvve1J5I+XtwJ/y79uTW+UYuU8vsYduVTzf33YXEQKLN1iB/6+Gcq1Rk8nfBMB1P7G+q3rRmcQiP1UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447357; c=relaxed/simple;
	bh=cT09hkWb6p1Q5laBg5r/C0k/WyFKDN1nFOp/f0E9EIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7CdUjXCUp+33uyPamcQNFV4/US8o/S/Rty7YsYjl7ti2syktNMKc88PpL6tJKD4rCfhTEy98iRisEt/m3OykfPmYtXCW/sz8LeTr657ltZfq2X7u6xHna+Z77b3ew/bEE8hrEqKdRkAGA7hEyHqwHty1KTH3Tz89SVnPk5cplg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gXjyZpFN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46f53f88e0bso30160395e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 06:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760447353; x=1761052153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XBmndkyEtmuH2zqfJVf2MipvEX2Eu2YJsa5R9Svl5+o=;
        b=gXjyZpFN7dPRuh+vX/6yZxiZDGG1mugCc3Ys83+jGOIfZiPoIIu6Muk8Bi6bRDciqQ
         kEqlVA/S/G90lP17leDC4Xhue0LATzQolxuZts/beHU2j7OUgIzJWtmUS32qc87vibUp
         dPTL96RLpIEagq8GNTPPHHZAWEVfm/fmLgrEGdBuR7P/Osj42j7USzNa1nOqQcZVoSTc
         v21buuptH8kZmQ9Eh+FXeVWwRu3m3iEeyX/JzdpVc3+idFRM04kgaWuciIeBBKJI2tRB
         LCWMX/t4aOA2bj69rpM2+hUlxQKGvylIkIaGRj3M661jQVHB7UfLKMgAgOGiCg8WMUxl
         rNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760447353; x=1761052153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBmndkyEtmuH2zqfJVf2MipvEX2Eu2YJsa5R9Svl5+o=;
        b=HejHhXpjTov3WmCU+IAOHLq7BLXFlr9+DCZKxKggU9gyGmTa81Ay2Ka4vK2rsb5LOn
         2fchvK2HjyJlYJK58yUd8tG+gGu4hxZwAkYBy15uATjIEmpo7DaOgGpuxXQQlABZGqKn
         JcvHgDzdRsznbai449Y4WdSC/FBF5noNR4TGQDXKaWBeipm8a9Ye+3IN94bVXLQYFRt0
         rFvV1PfKy8arvmYTZK9E3X9yq5AhAOJDIlqRcc6RdVh+2nBfen4/VytxIAqk9ELZFMaR
         wtjQxLhhL+7HwwYDgt0vI82qZitWDBN0pOzPkZCMIzIC94FnGMq1JjssIk4mzBOtf0a2
         sspQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYCGvIWoRaRHkf/aahgbPnxETRA7TKN2M5gPkfF3miXgToDQY4OJQfh4YawGG6hGeDnUZ3PHhDwvtcAKJclVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzkFwxLlzUn8k2eaIUrw2x2eBkWzB0BxDH5w1xW9T/qGefYJ1q
	zRoCx4KB1N/ZMZezzM0iZ/s/hd3+SzKSyIJC7aZfKGXoyjg50Qfu+xFlYenbsTo4iZU=
X-Gm-Gg: ASbGncsURv0ZotPB7uTbxm/s+oVX7B5ifvuF0KoyTOwKUc5TH41GMPNVSRaOMkfECYr
	wKDiA4CiBI3eMZLL8/dHX3r+eKl8gVvQRsdfoBPBw+wY5tkBVvjrC10uein0eDX5s/GizTEmAli
	wOgUh7RdU98nHJ+55QYRR4TvEYCHAB8QXVN5neojc6iB5UbfUvCjryYDfG0hDleJV2q3CbZRsXV
	fbUOApvsjtxR18/gqHQvv7YXwaPg5Pa7NV8fHW3zLQHr4ZB5bKjg/BJZGvi2Z58dKMzVdBrZ/QJ
	V+bZpi/tK4vVmROxObU2N0MC/X4gi5wLlJss7BfBT24L9/AlOQDo+7fqT8edPBMB4awdouYAa/W
	FacLGiuJBDK4L/DTh997aLMdiXiakodCN/5yfua8J6FfkbTsIHQ/5qigkdu5SJjTcqIlPvw==
X-Google-Smtp-Source: AGHT+IFGpYfRWYGhqIaSZxufyw3cU/D950Wt8EiMNsuJCAolvX6QytVu1nn4m6ZLSmt3VXgOJE+wuQ==
X-Received: by 2002:a05:6000:43d4:20b0:426:ed9d:4072 with SMTP id ffacd0b85a97d-426ed9d43d7mr1534097f8f.21.1760447352714;
        Tue, 14 Oct 2025 06:09:12 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cf70fsm22846162f8f.27.2025.10.14.06.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:09:12 -0700 (PDT)
Date: Tue, 14 Oct 2025 15:09:10 +0200
From: Petr Mladek <pmladek@suse.com>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: Lance Yang <lance.yang@linux.dev>,
	"wireguard@lists.zx2c4.com" <wireguard@lists.zx2c4.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>, Russell King <linux@armlinux.org.uk>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Joel Granados <joel.granados@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Phil Auld <pauld@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Florian Westphal <fw@strlen.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [????] Re: [PATCH][v3] hung_task: Panic after fixed number of
 hung tasks
Message-ID: <aO5Ldv4U8QSGgfog@pathway.suse.cz>
References: <20251012115035.2169-1-lirongqing@baidu.com>
 <588c1935-835f-4cab-9679-f31c1e903a9a@linux.dev>
 <aO4boXFaIb0_Wiif@pathway.suse.cz>
 <e3f7ddf68c2e42d7abf8643f34d84a18@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3f7ddf68c2e42d7abf8643f34d84a18@baidu.com>

On Tue 2025-10-14 10:49:53, Li,Rongqing wrote:
> 
> > On Tue 2025-10-14 13:23:58, Lance Yang wrote:
> > > Thanks for the patch!
> > >
> > > I noticed the implementation panics only when N tasks are detected
> > > within a single scan, because total_hung_task is reset for each
> > > check_hung_uninterruptible_tasks() run.
> > 
> > Great catch!
> > 
> > Does it make sense?
> > Is is the intended behavior, please?
> > 
> 
> Yes, this is intended behavior
> 
> > > So some suggestions to align the documentation with the code's
> > > behavior below :)
> > 
> > > On 2025/10/12 19:50, lirongqing wrote:
> > > > From: Li RongQing <lirongqing@baidu.com>
> > > >
> > > > Currently, when 'hung_task_panic' is enabled, the kernel panics
> > > > immediately upon detecting the first hung task. However, some hung
> > > > tasks are transient and the system can recover, while others are
> > > > persistent and may accumulate progressively.
> > 
> > My understanding is that this patch wanted to do:
> > 
> >    + report even temporary stalls
> >    + panic only when the stall was much longer and likely persistent
> > 
> > Which might make some sense. But the code does something else.
> > 
> 
> A single task hanging for an extended period may not be a critical
> issue, as users might still log into the system to investigate.
> However, if multiple tasks hang simultaneously-such as in cases
> of I/O hangs caused by disk failures-it could prevent users from
> logging in and become a serious problem, and a panic is expected.

I see. This another approach and it makes sense as well.
An this is much more clear description than the original text.

I would also update the subject to something like:

    hung_task: Panic when there are more than N hung tasks at the same time



That said, I think that both approaches make sense.

Your approach would trigger the panic when many processes are stuck.
Note that it still might be a transient state. But I agree that
the more stuck processes exist the more serious the problem
likely is for the heath of the system.

My approach would trigger panic when a single process hangs
for a long time. It will trigger more likely only when the problem
is persistent. The seriousness depends on which particular process
get stuck.

I am fine with your approach. Just please, make more clear that
the number means the number of hung tasks at the same time.
And mention the problems to login, ...

Best Regards,
Petr

