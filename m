Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0C809F988
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2019 06:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfH1Eph (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Aug 2019 00:45:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45397 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfH1Eph (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Aug 2019 00:45:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so693996pgp.12
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2019 21:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r4ofltqYkWIl3436n0V2gw36M3gWV6iDQWWhjHbjDBA=;
        b=QWkI1k50brs5Pa30E/uqgJVNIcW8k9c90/VZozs1j3z0FQz5uuZ9XUJlRNTPG+YUK1
         kDNiw5jzeWCk7esNWokDbJZDNa/5FHLSw1/kU5sSboSHN3zLUuL1Mkn/iB8w0AKFFSKS
         8ANiZeH/in/ORaVfnWcby4ywePOBINE3c/oINpYErHUOMM9BIz5G5slJiFZ8/0t3WgN6
         lxjb5fT4ZpVxc1OKzG0B5dDinfGMN2TYbVo3ackVw0J6eckviOZJ3LejPBxVIP5qpnjv
         lYGGwKLNQGDxiFjtTh6Qd5EHD+Wj9RLREyBCsx8Q4aJWz/AA5l0bMsb66UUkhAFPwAmk
         /3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r4ofltqYkWIl3436n0V2gw36M3gWV6iDQWWhjHbjDBA=;
        b=HlgG0g76jwB4HXts9QGpE4tIFLEbjDQihXbeJx2syPSuiHr8g5xg7zECkbHDXHwLTI
         yD+b68N3ziGwufuZzn3K+dVACIf1ZYGtSC68JlqAOGwGdv/Ag0d8Dsy4pO7SYTgR5PMh
         j12Ivvp26px1Q6KXFP3xIT6I28BymNbgmZ0nZ1E79MJ3Iuimjg3lTutPk9Ek2H3UZYOu
         zqcpcb/1/gPOjf2wlcfOjORjVaFQHHcbOS4gpLExxGQNC0C45wUqet0pclY0LqKjmUjI
         IoFR37XOe+3u6A55J3EjGS/5uidJcToWFijrA4DU3nVFtmBeR+k8XLMTXhB6H85XrijY
         TFWw==
X-Gm-Message-State: APjAAAUVNWTDHsZgitiOX53VQ/kvtMSlYtlD8V/chp87KLsIYc0m1TKI
        PvMjq0OFLzHa3gNc9XZWFyLFrA==
X-Google-Smtp-Source: APXvYqzPsIGCDYKrGP/dJlLB+WPFqV0pjgBAPoIm+ECbYlg0tdQQV1LHsAZIJtF3Wt1TJp6+Sp7ncg==
X-Received: by 2002:a63:6904:: with SMTP id e4mr1744616pgc.321.1566967535775;
        Tue, 27 Aug 2019 21:45:35 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id j11sm1021872pfa.113.2019.08.27.21.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 21:45:34 -0700 (PDT)
Date:   Tue, 27 Aug 2019 21:45:29 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     shuah@kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        frowand.list@gmail.com, sboyd@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v1] printk: add dummy vprintk_emit for when
 CONFIG_PRINTK=n
Message-ID: <20190828044529.GA30152@google.com>
References: <20190827234835.234473-1-brendanhiggins@google.com>
 <20190828030231.GA24069@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828030231.GA24069@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 28, 2019 at 12:02:31PM +0900, Sergey Senozhatsky wrote:
> On (08/27/19 16:48), Brendan Higgins wrote:
> > Previously vprintk_emit was only defined when CONFIG_PRINTK=y, this
> > caused a build failure in kunit/test.c when CONFIG_PRINTK was not set.
> > Add a no-op dummy so that callers don't have to ifdef around this.
> > 
> > Note: It has been suggested that this go in through the kselftest tree
> > along with the KUnit patches, because KUnit depends on this. See the
> > second link for the discussion on this.
> 
> Is there any reason for kunit to use vprintk_emit()? Can you switch
> to pr_err()/pr_info()/pr_foo()?
> 
> vprintk_emit() function is pretty internal. It's not static because
> drivers/base/core.c wants to add some extra payload to printk()
> messages (extended headers, etc).

I actually use it in a very similar way as dev_printk() does. I am using
it to define an equivalent kunit_printk(), which takes a log level, and
adds its own test information to the log.

What I have now is:

static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
{
	return vprintk_emit(0, level, NULL, 0, fmt, args);
}

static int kunit_printk_emit(int level, const char *fmt, ...)
{
	va_list args;
	int ret;

	va_start(args, fmt);
	ret = kunit_vprintk_emit(level, fmt, args);
	va_end(args);

	return ret;
}

static void kunit_vprintk(const struct kunit *test,
			  const char *level,
			  struct va_format *vaf)
{
	kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
}

The closest thing I can do without vprintk_emit is:

static void kunit_vprintk(const struct kunit *test,
			  const char *level,
			  struct va_format *vaf)
{
	printk("%s\t# %s: %pV", level, test->name, vaf);
}

But checkpatch complains:

WARNING: printk() should include KERN_<LEVEL> facility level

Based on the printk() implementation, it looks like it should be fine to
provide the level via format string since the formatting is performed
before the log level is checked; nevertheless, it seemed to me like
vprintk_emit was closer to what I wanted (again, it's what dev_printk
uses). Shuah and Tim seemed to agree with me:

https://lore.kernel.org/linux-kselftest/ECADFF3FD767C149AD96A924E7EA6EAF977A5D82@USCULXMSG01.am.sony.com/

Nevertheless, I probably don't want add any custom dict entries.

Really, what I think I want is a printk_level().

Thoughts?
