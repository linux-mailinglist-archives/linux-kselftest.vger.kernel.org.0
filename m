Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A90DCF141
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 05:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbfJHD3l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Oct 2019 23:29:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39467 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729973AbfJHD3l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Oct 2019 23:29:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id v4so9958408pff.6
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Oct 2019 20:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r5rY61uv0TbBekYVBoIpJ8HVOvZlHLYXTkq5V4p7fCg=;
        b=LU2lPXf7sxL6J2e6wTkTDrQeeog+JxhAgKTIIWv9q8Ytt3/107/c6qbGeoWBEeZZ+v
         oMvYZZqJ9ypOk6rnaKnklRhw9WIiEdocCp7ve4tdUyTn3MccriyPQb088k0B4sz/9/nd
         3Sm1OrcB/h1SFsHtrmMFmoGKHGTtj2uYb6kkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r5rY61uv0TbBekYVBoIpJ8HVOvZlHLYXTkq5V4p7fCg=;
        b=ZpI5+rvdpzOc+YoumufTFNDwxYTtLCjSAImeLGLiAPHW8RiOj+RBvcU7u24GpNyQrs
         QE6jxvHNAgjHJ2H/MUSWziZhSCbNWEUFSY59LGtwmcPpPuXIC1QyKfYogyBs0UFZst4i
         jOg78sJzxKQiVv1PNUOqoMxfOdN/KUCiKY32HHgJEEQXzIPhSCSnHOqESrosgzYF1LzS
         8VAKcOBQ+hGNqQPCQxOgILWuq1R5VzMyGb1auYe6PXwp3EnYxDZtYhA/pZBy7KVjmmyi
         aCKhQiTtMg7yQt7eSLqmWSdDxAQWqDDY5D4jSv+GTANFDF8ycZaFdge9nMnPKk/CPpaY
         d2/w==
X-Gm-Message-State: APjAAAX2btBGCEjwbd76/LsRErIkpJKosGHG7e2bZYrpODTYMnwFNj5F
        UPOmeCOdoNd6YXH6JO9UKi+Zdw==
X-Google-Smtp-Source: APXvYqxbDbVLe1YIwV3eUnWXg4A3HRU9Iqjt0HY6IkSzyLI4VO66EII/A2LwB+c7qQL01M6ejs5ucA==
X-Received: by 2002:a17:90a:db47:: with SMTP id u7mr2947520pjx.40.1570505378971;
        Mon, 07 Oct 2019 20:29:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r24sm15647308pfh.69.2019.10.07.20.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 20:29:38 -0700 (PDT)
Date:   Mon, 7 Oct 2019 20:29:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, brendanhiggins@google.com,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/list-test: add a test for the 'list' doubly linked
 list
Message-ID: <201910072028.C7AB93651@keescook>
References: <20191007213633.92565-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007213633.92565-1-davidgow@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 07, 2019 at 02:36:33PM -0700, David Gow wrote:
> +config LIST_TEST
> +	bool "KUnit Test for Kernel Linked-list stuctures"

I missed this the first time through: typo of "structures"

-- 
Kees Cook
