Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 685389F9C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2019 07:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfH1FYK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Aug 2019 01:24:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46748 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfH1FYK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Aug 2019 01:24:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id q139so887105pfc.13;
        Tue, 27 Aug 2019 22:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dhdmXWrPSEQR4IZD4RGdgvn2ki148613KDqA6rGmWaI=;
        b=i4noJJp/M0iD0dPteicCV8FGVXl2m1GkFp8vAJTAej0neka8LLxDZ3YK8WUC3H6g8N
         vOqWi/cOcdC4U6RkntBrYPeqPxElNnIy+tIOqzea9nkpEjQXLZC6DnXOx0Ujd/WdYc34
         78i43ywWSE3Q09hx06YRFdr0CbEQQnS+iWFWh9JLxQjUonYN0p0SEKJQCIGg6SjDWgdI
         Vfn1pDIPbOVQ+/IHni7frGrYxu/VeJ32DsHnsM7wvnATAjDkdjO8HvPi6hjjB5xTrzEK
         b0bTwvZpU6ripnoiRwhd6gsisBjXgHh4EU1YjhbyDB10sxuSwp9L6lt1ZbvXIrXC/wbn
         vpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dhdmXWrPSEQR4IZD4RGdgvn2ki148613KDqA6rGmWaI=;
        b=Di6Ntv/T9vlZWC7ib+G2pu4MhxmsFjN70SHdXXG2QhpX03KyKcaqorHQ1HQil5m+p+
         +QX5uBFm0gjViGjUrSjcdIn03A6xjdjXX8Ndewl0+Opm6innlVIC4XSSNRdmMrhFTyZL
         D+175wwi1sLveYCPeA2ljPEw8ONFNjNmFxFNeuj7BPeqCPct3KZE3f95AEMUSTXxs5ZX
         U9WIC10r/oP951xe2pN78P3zbPGdwEfkmEajrScY1uCcpPcI5AzCapZFcN7f0qq6hAEO
         WPfaBIiyiZ52bcGphTMfgHe+C8qZJfSgE0uRiI+qi+qmA18YUzeKYDsVfT9Re2XmFMjB
         5tKA==
X-Gm-Message-State: APjAAAXrE0PLR+VvBbR93zJUJspqgM319wxP8rs/4eOVYB4UGhoXfkJc
        S9PTCQvbTqsOm/+06SbmAXM=
X-Google-Smtp-Source: APXvYqz/5YFoNR5M/xs4inkuDaLGA7dlFEHHBrYKZRgHiAKVZ9UdSKE7ntbJiGhDLAj/HBTM/tO2Ag==
X-Received: by 2002:a62:144f:: with SMTP id 76mr2648466pfu.62.1566969849639;
        Tue, 27 Aug 2019 22:24:09 -0700 (PDT)
Received: from localhost ([39.7.47.251])
        by smtp.gmail.com with ESMTPSA id e3sm920351pjr.9.2019.08.27.22.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 22:24:08 -0700 (PDT)
Date:   Wed, 28 Aug 2019 14:24:05 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        shuah@kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        frowand.list@gmail.com, sboyd@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v1] printk: add dummy vprintk_emit for when
 CONFIG_PRINTK=n
Message-ID: <20190828052405.GA526@jagdpanzerIV>
References: <20190827234835.234473-1-brendanhiggins@google.com>
 <20190828030231.GA24069@jagdpanzerIV>
 <20190828044529.GA30152@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828044529.GA30152@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On (08/27/19 21:45), Brendan Higgins wrote:
[..]
> I actually use it in a very similar way as dev_printk() does. I am using
> it to define an equivalent kunit_printk(), which takes a log level, and
> adds its own test information to the log.
> 
> What I have now is:
> 
> static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
> {
> 	return vprintk_emit(0, level, NULL, 0, fmt, args);
> }
> 
> static int kunit_printk_emit(int level, const char *fmt, ...)
> {
> 	va_list args;
> 	int ret;
> 
> 	va_start(args, fmt);
> 	ret = kunit_vprintk_emit(level, fmt, args);
> 	va_end(args);
> 
> 	return ret;
> }
> 
> static void kunit_vprintk(const struct kunit *test,
> 			  const char *level,
> 			  struct va_format *vaf)
> {
> 	kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
> }

Basically, for prefixes we have pr_fmt().

#define pr_fmt(fmt) "module name: " fmt

but pr_fmt() is mostly for static prefixes. If that doesn't work for
you, then maybe you can tweak kunit_foo() macros?

E.g. something like this

#define kunit_info(test, fmt, ...)                                   \
	printk(KERN_INFO "\t# %s: " pr_fmt(fmt), (test)->name, ##__VA_ARGS__)

#define kunit_err(test, fmt, ...)                                    \
	printk(KERN_ERR "\t# %s: " pr_fmt(fmt), (test)->name, ##__VA_ARGS__)

#define kunit_debug(test, fmt, ...)                                  \
	printk(KERN_DEBUG "\t# %s: " pr_fmt(fmt), (test)->name, ##__VA_ARGS__)

Would that do the trick? Am I missing something?

	-ss
