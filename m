Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0683E3433F8
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Mar 2021 19:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhCUSBR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Mar 2021 14:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhCUSBG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Mar 2021 14:01:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CF2C061764
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Mar 2021 11:01:05 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ha17so7193481pjb.2
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Mar 2021 11:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iBrKCN7co0fN6DQ3Z7oVF42ggkUDpYbjPmhV3o6bWXE=;
        b=cCKPMhwksUZ+yG1vaCu6wa8LkufPS1iF7vvliCffs1hluULxo1HADGt4q9mvtjBqIR
         U1ubZko3f81D30hNlvfAjNKNIaI/FvSlsAfUF32Cr2jNM/Z3Uvzr6yN9spxjY+SqBjwB
         ZW++v4cMTbXPBele8dErnlXmZCdJPemi1xzbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iBrKCN7co0fN6DQ3Z7oVF42ggkUDpYbjPmhV3o6bWXE=;
        b=Ft70XobnbLdWEBnymVyy0CQXwt6J05USlQxCpmUqaum/CEStcN3xkhhwYTe9FDph2V
         e5DvWnaTjESvhou+HUJLnwdS8ezD9BhpSrSu87v+jJAO7F6/FAajZo2Yv8vIRz5NbUD8
         P9tPACVzo/VPhjUuRaalQuPrn60R9wvlOExzymAJNzPWMPFjLtfSp3FD/sztDiy3Zw5g
         1fjSK8fLcOwJyFNBxze50BPJ33ZkrV2LDZnxolKFXGfBctx3Dcct+S6jBWZLAhyLolp8
         Vcz/ycjb/xZZXQ+Vh8sN5r7J9qDX1OB64LVs93FVGPnKmPvCRZom5DYlGoErpzl2q2WG
         XOqA==
X-Gm-Message-State: AOAM533xttZsotuE+gaLE7Gpj1ESdPjgiyLAPIxcnWZgBE/QcUJf+xJg
        H7sgM75QhGeNvXHkPcrQv/cP9w==
X-Google-Smtp-Source: ABdhPJzKcyFhLu+VVYrkrgFkX1seObKVaaqxd2+uvQ/k/gufXuSV0xwmK/GIaFl5VVtZ13L/Yakkaw==
X-Received: by 2002:a17:90b:116:: with SMTP id p22mr9044261pjz.161.1616349664842;
        Sun, 21 Mar 2021 11:01:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l190sm11312520pfl.73.2021.03.21.11.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 11:01:04 -0700 (PDT)
Date:   Sun, 21 Mar 2021 11:01:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Wood <john.wood@gmx.com>
Cc:     Jann Horn <jannh@google.com>, Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        Shuah Khan <shuah@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v6 4/8] security/brute: Fine tuning the attack detection
Message-ID: <202103211038.99C87F12@keescook>
References: <20210307113031.11671-1-john.wood@gmx.com>
 <20210307113031.11671-5-john.wood@gmx.com>
 <202103171957.16C0560D@keescook>
 <20210320154648.GC3023@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320154648.GC3023@ubuntu>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Mar 20, 2021 at 04:46:48PM +0100, John Wood wrote:
> On Wed, Mar 17, 2021 at 09:00:51PM -0700, Kees Cook wrote:
> > On Sun, Mar 07, 2021 at 12:30:27PM +0100, John Wood wrote:
> > > +/**
> > > + * brute_reset_stats() - Reset the statistical data.
> > > + * @stats: Statistics to be reset.
> > > + * @is_setid: The executable file has the setid flags set.
> > > + *
> > > + * Reset the faults and period and set the last crash timestamp to now. This
> > > + * way, it is possible to compute the application crash period at the next
> > > + * fault. Also, save the credentials of the current task and update the
> > > + * bounds_crossed flag based on a previous network activity and the is_setid
> > > + * parameter.
> > > + *
> > > + * The statistics to be reset cannot be NULL.
> > > + *
> > > + * Context: Must be called with interrupts disabled and brute_stats_ptr_lock
> > > + *          and brute_stats::lock held.
> > > + */
> > > +static void brute_reset_stats(struct brute_stats *stats, bool is_setid)
> > > +{
> > > +	const struct cred *cred = current_cred();
> > > +
> > > +	stats->faults = 0;
> > > +	stats->jiffies = get_jiffies_64();
> > > +	stats->period = 0;
> > > +	stats->saved_cred.uid = cred->uid;
> > > +	stats->saved_cred.gid = cred->gid;
> > > +	stats->saved_cred.suid = cred->suid;
> > > +	stats->saved_cred.sgid = cred->sgid;
> > > +	stats->saved_cred.euid = cred->euid;
> > > +	stats->saved_cred.egid = cred->egid;
> > > +	stats->saved_cred.fsuid = cred->fsuid;
> > > +	stats->saved_cred.fsgid = cred->fsgid;
> > > +	stats->bounds_crossed = stats->network || is_setid;
> > > +}
> >
> > I would include brute_reset_stats() in the first patch (and add to it as
> > needed). To that end, it can start with a memset(stats, 0, sizeof(*stats));
> 
> So, need all the struct fields to be introduced in the initial patch?
> Even if they are not needed in the initial patch? I'm confused.

No, I meant try to introduce as much infrastructure as possible early in
the series. In this case, I was suggesting having introduced
brute_reset_stats() at the start, so that in this patch you'd just be
adding the new fields to the function. (Instead of both adding new
fields and changing the execution pattern.)

> > > +/**
> > > + * brute_network() - Target for the socket_sock_rcv_skb hook.
> > > + * @sk: Contains the sock (not socket) associated with the incoming sk_buff.
> > > + * @skb: Contains the incoming network data.
> > > + *
> > > + * A previous step to detect that a network to local boundary has been crossed
> > > + * is to detect if there is network activity. To do this, it is only necessary
> > > + * to check if there are data packets received from a network device other than
> > > + * loopback.
> > > + *
> > > + * It's mandatory to disable interrupts before acquiring brute_stats_ptr_lock
> > > + * and brute_stats::lock since the task_free hook can be called from an IRQ
> > > + * context during the execution of the socket_sock_rcv_skb hook.
> > > + *
> > > + * Return: -EFAULT if the current task doesn't have statistical data. Zero
> > > + *         otherwise.
> > > + */
> > > +static int brute_network(struct sock *sk, struct sk_buff *skb)
> > > +{
> > > +	struct brute_stats **stats;
> > > +	unsigned long flags;
> > > +
> > > +	if (!skb->dev || (skb->dev->flags & IFF_LOOPBACK))
> > > +		return 0;

I wonder if you need to also ignore netlink, unix sockets, etc, or does
the IFF_LOOPBACK cover those too?

> > > +
> > > +	stats = brute_stats_ptr(current);
> >
> > Uhh, is "current" valid here? I actually don't know this hook very well.
> 
> I think so, but I will try to study it. Thanks for noted this.

I think you might need to track the mapping of task to sock via
security_socket_post_create(), security_socket_accept(),
and/or security_socket_connect()?

Perhaps just mark it once with security_socket_post_create(), instead of
running a hook on every incoming network packet, too?

-Kees

> > > +	read_lock_irqsave(&brute_stats_ptr_lock, flags);
> > > +
> > > +	if (!*stats) {
> > > +		read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> > > +		return -EFAULT;
> > > +	}
> > > +
> > > +	spin_lock(&(*stats)->lock);
> > > +	(*stats)->network = true;
> > > +	spin_unlock(&(*stats)->lock);
> > > +	read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> > > +	return 0;
> > > +}
> 
> Thanks,
> John Wood

-- 
Kees Cook
