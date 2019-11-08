Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 707C5F4FC9
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2019 16:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfKHPeP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Nov 2019 10:34:15 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34902 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfKHPeP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Nov 2019 10:34:15 -0500
Received: by mail-pf1-f195.google.com with SMTP id d13so4829527pfq.2
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Nov 2019 07:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qj+fxcw/f/zBWkhx1n1H3p7wLqAe4gVBZqI/aXNQxWk=;
        b=rg+96yACuf0WNFAbNBolENWXNfzTsgllhU9Lu/cKxAhsm9fNVQMjn0iHib5iXLrIKy
         4ht2PRAcyGbqzSaBjjbBD2EOEsb07PYkPuF9ikvH43uGaUPfIbtJk8lFDkPCLI1XR8hS
         2AVs+/sUSn4eOTnMkIjAK0XPcmykZsVhmQTIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qj+fxcw/f/zBWkhx1n1H3p7wLqAe4gVBZqI/aXNQxWk=;
        b=kSsq6uYMj8audrsy8x2arqfJZ+G6KC2rna2SZR4TALjtRlyhlLr0sDLU1Lfn2/EvBz
         NAhhRoY4FN3OvkLWkAMFpMfYw2Zx4bp0TE/phOmJz7piOoEkTU83psWeeo8bdRq/1oL3
         WxqxVVDuFznbeMjhDoouxI5Enz3F0MzaBDhuPbZQi7OqCWO2vv0FSVksMYvtjCSwb09g
         L29QIIV2jPVwKF3KzoVdkwBuXoSSkzjRAg2J3cC6VH2jc2XJz8KuE/U6cShJUGzUmrQF
         hLn6zi9Rk5EfrtHRohsXFeBVp8bpp0Q40KjwZvYyJdh4d9cEnqL5x0/0ZRBXJRFqlQTK
         OWtQ==
X-Gm-Message-State: APjAAAWlO2C63VYiQ1g417MW4qYb4z8wjuf/F4EWBQhqWN/HHSUm9FT2
        998joQvWoGyv6ja6YY/XxkCnPw==
X-Google-Smtp-Source: APXvYqwSoI3TF80yU99qYDKkeTfcy4sTEJwGlf6rpu9XXhNevu4ndPDIEfa5bbnolSMgHzBhXQTIQw==
X-Received: by 2002:a17:90a:6583:: with SMTP id k3mr14324030pjj.50.1573227252739;
        Fri, 08 Nov 2019 07:34:12 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b128sm2331777pfg.65.2019.11.08.07.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 07:34:12 -0800 (PST)
Date:   Fri, 8 Nov 2019 10:34:10 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Nicolas Geoffray <ngeoffray@google.com>,
        kernel-team@android.com, Hugh Dickins <hughd@google.com>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/2] memfd: Fix COW issue on MAP_PRIVATE and
 F_SEAL_FUTURE_WRITE mappings
Message-ID: <20191108153410.GB99567@google.com>
References: <20191107195355.80608-1-joel@joelfernandes.org>
 <20191107170023.0695732bb67eb80acd4caee5@linux-foundation.org>
 <20191108020614.GA99567@google.com>
 <20191108063715.GA513315@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108063715.GA513315@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 08, 2019 at 07:37:15AM +0100, Greg KH wrote:
> On Thu, Nov 07, 2019 at 09:06:14PM -0500, Joel Fernandes wrote:
> > On Thu, Nov 07, 2019 at 05:00:23PM -0800, Andrew Morton wrote:
> > > On Thu,  7 Nov 2019 14:53:54 -0500 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> > > 
> > > > F_SEAL_FUTURE_WRITE has unexpected behavior when used with MAP_PRIVATE:
> > > > A private mapping created after the memfd file that gets sealed with
> > > > F_SEAL_FUTURE_WRITE loses the copy-on-write at fork behavior, meaning
> > > > children and parent share the same memory, even though the mapping is
> > > > private.
> > > 
> > > That sounds fairly serious.  Should this be backported into -stable kernels?
> > 
> > Yes, it should be. The F_SEAL_FUTURE_WRITE feature was introduced in v5.1 so
> > v5.3.x stable kernels would need a backport. I can submit a backport tomorrow
> > unless we are Ok with stable automatically picking it up (I believe the
> > stable folks "auto select" fixes which should detect this is a fix since I
> > have said it is a fix in the subject line).
> 
> Never rely on "auto select" to pick up a patch for stable if you already
> know it should go to stable.  Just mark it as such, or tell stable@vger
> after the fact.

Sure, agreed.

Thanks Andrew for adding the tags!

thanks,

 - Joel

