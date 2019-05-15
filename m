Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9E91F7D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2019 17:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfEOPk0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 May 2019 11:40:26 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39945 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfEOPkU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 May 2019 11:40:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id j12so431160eds.7
        for <linux-kselftest@vger.kernel.org>; Wed, 15 May 2019 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xdgkq7E7+92ZW8x2Wkn7bfn+NRy1PNeG8DcUh6bxPio=;
        b=bfuTPZdAtZJEgr+LRkX72jzoj84BPgpwvQPX7TINdboNhdzKNjJGvDzVvqvaaAh8Km
         iqTakFfgT4CJH4/cI6DSpX88s8Sfap4XoOKg2RDeLLxirLNHPqbOEbbj/6aCt06XF/9P
         X/us6CYYROr8DPKhgLY3SLh3ZeL1/eih/MR9PMbtrWfnl7CFIcBUAogBL0DY90Buod6x
         uECgJQv/SirIkuk/ECloyg95oA5R0oldoWVKg0CvJmRDjoeJEJ6edtPOwuBN6C4fcGnO
         BW2YYNw0hfraOKLIXAT/1qzfZOA/kv0yJLeVZCoYp69fdwL2bHQEsKScA+TLGS8z8aPr
         de9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xdgkq7E7+92ZW8x2Wkn7bfn+NRy1PNeG8DcUh6bxPio=;
        b=FjUV0H3f8Rzx+obPJ+2jESNU+Vu+Dg3BsJ0cuaS3zLQ6rG/EO485wwJncsGpTbpJWI
         KMkzFX688zrzFzVTqATQdoLVPKrJGAtrLijU0KCJMN8aeG/6ubmK117HgzA8VcuwKVd/
         ykP/rMHnPLrZSMKeqShh7GezcGv4m6WMWdzoyGHt0M7QZB3udeLFr9gj9ZUPXwwqgSXv
         OZk9iJi3JQYN5yryXAFqNvbG5FxEztdFIYQRiEoTfFB+8+wZoD7T9iEFsYZRoyFJsJYd
         bh0BrshlTdWjGi9QVd2yaM0Wk/KXAW15aSAq0rqa95ejZvZZJqStd6UlzkXQ12SNIUWB
         e9uw==
X-Gm-Message-State: APjAAAUfaikngn8NfRZtTNZ/enLCuhrf2wydrD+y2CxWxEIyTmi94/St
        4c81TM3CpGgYxJgjlMk9PBHRxw==
X-Google-Smtp-Source: APXvYqwxmqRE9VJlOAD22A4kr7WHnyESSHU1d/yh8q05kzTP6OSdD5czfo3EsMWHZUHFy4XAQOiyOg==
X-Received: by 2002:a50:87b5:: with SMTP id a50mr42379905eda.118.1557934819122;
        Wed, 15 May 2019 08:40:19 -0700 (PDT)
Received: from brauner.io ([193.96.224.243])
        by smtp.gmail.com with ESMTPSA id p52sm887134eda.79.2019.05.15.08.40.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 15 May 2019 08:40:18 -0700 (PDT)
Date:   Wed, 15 May 2019 17:40:15 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     jannh@google.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, dhowells@redhat.com, akpm@linux-foundation.org,
        cyphar@cyphar.com, ebiederm@xmission.com,
        elena.reshetova@intel.com, keescook@chromium.org,
        luto@amacapital.net, luto@kernel.org, tglx@linutronix.de,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] pid: add pidfd_open()
Message-ID: <20190515154014.4jaxuw4fcgbusnbt@brauner.io>
References: <20190515100400.3450-1-christian@brauner.io>
 <20190515143857.GB18892@redhat.com>
 <20190515153515.GA20783@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190515153515.GA20783@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 15, 2019 at 05:35:15PM +0200, Oleg Nesterov wrote:
> On 05/15, Oleg Nesterov wrote:
> >
> > On 05/15, Christian Brauner wrote:
> > >
> > > +SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
> > > +{
> > > +	int fd, ret;
> > > +	struct pid *p;
> > > +	struct task_struct *tsk;
> > > +
> > > +	if (flags)
> > > +		return -EINVAL;
> > > +
> > > +	if (pid <= 0)
> > > +		return -EINVAL;
> > > +
> > > +	p = find_get_pid(pid);
> > > +	if (!p)
> > > +		return -ESRCH;
> > > +
> > > +	rcu_read_lock();
> > > +	tsk = pid_task(p, PIDTYPE_PID);
> >
> > You do not need find_get_pid() before rcu_lock and put_pid() at the end.
> > You can just do find_vpid() under rcu_read_lock().
> 
> Ah, sorry. Somehow I forgot you need to call pidfd_create(pid), you can't
> do this under rcu_read_lock().
> 
> So I was wrong, you can't avoid get/put_pid.

Yeah, I haven't made any changes yet.

Christian
