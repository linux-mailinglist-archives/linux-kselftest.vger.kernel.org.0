Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF8A2132A98
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2020 17:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgAGQAp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jan 2020 11:00:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53307 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728052AbgAGQAo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jan 2020 11:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578412843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2tgaAOxuK+BpANAaDpR2VlivTHiWdjlqBTqnI3DjVok=;
        b=LjN4aTYcQxbO7LbW9MA6SYvPuCvFZED853HbQ7ytOotk0LaJcyw2NWOWcJZRRoK7tT1TsV
        VjNt+azc+ivEB/zy+GiiAZ46+K4qkVAKikCFHb0Hh9im8UEThyJ8TNxX7Y1bl766zFyatf
        bwydIxpuILErerqrqluXmU+65QIV90s=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-iF9aTLfMMhyOr71Klu6ing-1; Tue, 07 Jan 2020 11:00:38 -0500
X-MC-Unique: iF9aTLfMMhyOr71Klu6ing-1
Received: by mail-qv1-f71.google.com with SMTP id a14so163296qvy.23
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jan 2020 08:00:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2tgaAOxuK+BpANAaDpR2VlivTHiWdjlqBTqnI3DjVok=;
        b=KSaoHZDape19RoD1iy6s111dMHgnaLsUBNZsKCPGsDzps0MRbiaA9v28QWqQi1HNuB
         B8Z2f/SqbFmI5CRBLrUh9HXAM/0EC/lrY/ExqfsgnwS+yuwavjMjFTApX8iARHDfqu2m
         gtEGssVdiNy3janxpXU4FTirOHLj9WBvN25JBUlarBwTDeeH9of8zZiE78qbbf51qM4q
         EslkGxHVi/2JLCh/vVoyXmtzWxL1OnrwSAz0H6PHdx2TKTIYSIJYR3rmprggWJONJ2fR
         EMtdw4oZmRn9IUfPiuDfzw+6BvwB5TJ45HEPspybDY3OYz0L4gSYac3YJWBnAOO771af
         BjGw==
X-Gm-Message-State: APjAAAUk17c7BGNRVphUqLftJtMMW5yzIA0DtGJ9Lpbp570r/rWM74zd
        J56sU0itFW/B8bFRLEnUeu1/nURwIllZw4ji0GZiuPUckNOT4MEMBY1WCrRuHat7YoStI+uBuL8
        BitaQfxpMB/4ZUl+eMUO44raXhNje
X-Received: by 2002:ad4:5614:: with SMTP id ca20mr77303qvb.43.1578412838066;
        Tue, 07 Jan 2020 08:00:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqxco4tN6LuFo9JPmqxefJvTz1h/hHztoZLdPyxjrU9NmEQbj/K8aPW34C5/taBpDrO7OrLbbw==
X-Received: by 2002:ad4:5614:: with SMTP id ca20mr77269qvb.43.1578412837710;
        Tue, 07 Jan 2020 08:00:37 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id t1sm20365985qkt.129.2020.01.07.08.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 08:00:37 -0800 (PST)
Date:   Tue, 7 Jan 2020 11:00:35 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v3 2/8] KVM: selftests: Add demand paging content to the
 demand paging test
Message-ID: <20200107160035.GG219677@xz-x1>
References: <20191216213901.106941-1-bgardon@google.com>
 <20191216213901.106941-3-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191216213901.106941-3-bgardon@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 16, 2019 at 01:38:55PM -0800, Ben Gardon wrote:

[...]

> +static void *uffd_handler_thread_fn(void *arg)
> +{
> +	struct uffd_handler_args *uffd_args = (struct uffd_handler_args *)arg;
> +	int uffd = uffd_args->uffd;
> +	int64_t pages = 0;
> +
> +	while (!quit_uffd_thread) {
> +		struct uffd_msg msg;
> +		struct pollfd pollfd[1];
> +		int r;
> +		uint64_t addr;
> +
> +		pollfd[0].fd = uffd;
> +		pollfd[0].events = POLLIN;
> +
> +		/*
> +		 * TODO this introduces a 0.5sec delay at the end of the test.
> +		 * Reduce the timeout or eliminate it following the example in
> +		 * tools/testing/selftests/vm/userfaultfd.c
> +		 */
> +		r = poll(pollfd, 1, 500);

Would you mind implement it instead of adding a todo?  IIUC it's as
simple as a few more lines than the comment itself.  Thanks,

-- 
Peter Xu

