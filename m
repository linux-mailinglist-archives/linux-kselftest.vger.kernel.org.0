Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF21A3DCC
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 20:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfH3Si2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 14:38:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45862 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbfH3Si2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 14:38:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id 4so401350pgm.12
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2019 11:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X/C+aQdtHW6s8FWFPY1FOvHjUqoRJs9dEy0Z1mafQgc=;
        b=Tu6eRrQMMKoSUNjXqpmKPoOL5KUWPEOTR4Wc7fnAr2GbRmm12VVM4HJyDdXrf93Wcl
         rZD1vNgcVeWiGHUN1TDzIpj8q6jsLV6sut9NlxM5e0qM36HoVwBxO+yvPilvx/rZISlh
         Uvrj9CKFeurwuKY2iXcrG1l7fMZSNVA89I5XMANdX5onUYj3wpkj3gIuRQ0aImIH0/gP
         si13vIVz0MDyTf5V1H1K6BeeKwqWmQ7tNR3dVqVB973sJGwdGtCCPaFjzIOvb5tuabmo
         Vhe5ohUX02Q8+noRsg11yFG+3MUOBzHJxs25kc5K+uvRhqQ/ydJZKQhExZnhaaX8QyMV
         fWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X/C+aQdtHW6s8FWFPY1FOvHjUqoRJs9dEy0Z1mafQgc=;
        b=TDw3X1yrdnph8sd1VkZjcg5a7jqbD1hBsmxuV+8cr70HXxWio9A0evGuI3yO4fEMzc
         TunT6yYtLm3RFomYZEb5iRqwb8P1EAAhE3X4uPu2xwxXUwrcsrV4GOrggjk1j4E6CP6Y
         I5tEdqdE9GkGPWvdNKBcYNet7CFufXlGF9iRokHu4CizHQDIBCDIwdiHENmaf2VihJ0E
         aNajy/+xnazsHK5kaI4STbPFiPwDymSOUYpABPBLvHj8WaMFi51yDvCodY9ZixhQJMF9
         9DhDXHITb7shQTgwMO0YuuJ6KXBdnPfhSt8LRn75O5N0FX5bCKLK22rzVJsecXykRCmH
         HXFg==
X-Gm-Message-State: APjAAAXWKSPGX5dySpmZrZyBGyoxYAnDy9fybyWr1IxZJPV6Jgu1D79J
        kSR1sb+E1p5xsmOSFSowtp5OgQ==
X-Google-Smtp-Source: APXvYqyfREvD/M1d4OOt5J2BD/xjkKH2rmWw1824b7w9470tcs1uaveYn4ctEsNoWWZGf83O8oSktA==
X-Received: by 2002:a63:e48:: with SMTP id 8mr13942902pgo.389.1567190306448;
        Fri, 30 Aug 2019 11:38:26 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id b126sm17628543pfa.177.2019.08.30.11.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 11:38:25 -0700 (PDT)
Date:   Fri, 30 Aug 2019 11:38:21 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Joe Perches <joe@perches.com>
Cc:     shuah <shuah@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        sboyd@kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] kunit: fix failure to build without printk
Message-ID: <20190830183821.GA30306@google.com>
References: <20190828093143.163302-1-brendanhiggins@google.com>
 <20190828094929.GA14038@jagdpanzerIV>
 <8b2d63bf-56cd-e8f5-e8ee-2891c2c1be8f@kernel.org>
 <f2d5b474411b2940d62198490f06e77890fbdb32.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2d5b474411b2940d62198490f06e77890fbdb32.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 29, 2019 at 09:44:58PM -0700, Joe Perches wrote:
> On Thu, 2019-08-29 at 11:01 -0600, shuah wrote:
> > On 8/28/19 3:49 AM, Sergey Senozhatsky wrote:
> > > On (08/28/19 02:31), Brendan Higgins wrote:
> > > [..]
> > > > Previously KUnit assumed that printk would always be present, which is
> > > > not a valid assumption to make. Fix that by removing call to
> > > > vprintk_emit, and calling printk directly.
> > > > 
> > > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > > Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
> > > > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> > > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > 
> > > [..]
> > > 
> > > > -static void kunit_vprintk(const struct kunit *test,
> > > > -			  const char *level,
> > > > -			  struct va_format *vaf)
> > > > -{
> > > > -	kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
> > > > -}
> > > 
> > > This patch looks good to me. I like the removal of recursive
> > > vsprintf() (%pV).
> > > 
> > > 	-ss
> > > 
> > 
> > Hi Sergey,
> > 
> > What are the guidelines for using printk(). I recall some discussion
> > about not using printk(). I am seeing the following from checkpatch
> > script:
> > 
> > 
> > WARNING: Prefer [subsystem eg: netdev]_level([subsystem]dev, ... then 
> > dev_level(dev, ... then pr_level(...  to printk(KERN_LEVEL ...
> > #105: FILE: include/kunit/test.h:343:
> > +	printk(KERN_LEVEL "\t# %s: " fmt, (test)->name, ##__VA_ARGS__)
> > 
> > 
> > Is there supposed to be pr_level() - I can find dev_level()
> > 
> > cc'ing Joe Perches for his feedback on this message recommending
> > pr_level() which isn't in 5.3.
> 
> I don't care for pr_level or KERN_LEVEL in a printk.

I don't think I follow, how does your version fix this?

> I think this is somewhat overly complicated.
> 
> I think I'd write it like:
> ---
>  include/kunit/test.h | 11 ++++-----
>  kunit/test.c         | 69 ++++++++++++++++------------------------------------
>  2 files changed, 26 insertions(+), 54 deletions(-)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 8b7eb03d4971..aa4abf0a22a5 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -339,9 +339,8 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
>  
>  void kunit_cleanup(struct kunit *test);
>  
> -void __printf(3, 4) kunit_printk(const char *level,
> -				 const struct kunit *test,
> -				 const char *fmt, ...);
> +__printf(2, 3)
> +void kunit_printk(const struct kunit *test, const char *fmt, ...);
>  
>  /**
>   * kunit_info() - Prints an INFO level message associated with @test.
> @@ -353,7 +352,7 @@ void __printf(3, 4) kunit_printk(const char *level,
>   * Takes a variable number of format parameters just like printk().
>   */
>  #define kunit_info(test, fmt, ...) \
> -	kunit_printk(KERN_INFO, test, fmt, ##__VA_ARGS__)
> +	kunit_printk(test, KERN_INFO fmt, ##__VA_ARGS__)
>  
>  /**
>   * kunit_warn() - Prints a WARN level message associated with @test.
> @@ -364,7 +363,7 @@ void __printf(3, 4) kunit_printk(const char *level,
>   * Prints a warning level message.
>   */
>  #define kunit_warn(test, fmt, ...) \
> -	kunit_printk(KERN_WARNING, test, fmt, ##__VA_ARGS__)
> +	kunit_printk(test, KERN_WARNING fmt, ##__VA_ARGS__)
>  
>  /**
>   * kunit_err() - Prints an ERROR level message associated with @test.
> @@ -375,7 +374,7 @@ void __printf(3, 4) kunit_printk(const char *level,
>   * Prints an error level message.
>   */
>  #define kunit_err(test, fmt, ...) \
> -	kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
> +	kunit_printk(test, KERN_ERR fmt, ##__VA_ARGS__)
>  
>  /**
>   * KUNIT_SUCCEED() - A no-op expectation. Only exists for code clarity.
> diff --git a/kunit/test.c b/kunit/test.c
> index b2ca9b94c353..ddb9bffb5a5d 100644
> --- a/kunit/test.c
> +++ b/kunit/test.c
> @@ -16,40 +16,6 @@ static void kunit_set_failure(struct kunit *test)
>  	WRITE_ONCE(test->success, false);
>  }
>  
> -static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
> -{
> -	return vprintk_emit(0, level, NULL, 0, fmt, args);
> -}
> -
> -static int kunit_printk_emit(int level, const char *fmt, ...)
> -{
> -	va_list args;
> -	int ret;
> -
> -	va_start(args, fmt);
> -	ret = kunit_vprintk_emit(level, fmt, args);
> -	va_end(args);
> -
> -	return ret;
> -}
> -
> -static void kunit_vprintk(const struct kunit *test,
> -			  const char *level,
> -			  struct va_format *vaf)
> -{
> -	kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
> -}
> -
> -static void kunit_print_tap_version(void)
> -{
> -	static bool kunit_has_printed_tap_version;
> -
> -	if (!kunit_has_printed_tap_version) {
> -		kunit_printk_emit(LOGLEVEL_INFO, "TAP version 14\n");
> -		kunit_has_printed_tap_version = true;
> -	}
> -}
> -
>  static size_t kunit_test_cases_len(struct kunit_case *test_cases)
>  {
>  	struct kunit_case *test_case;
> @@ -63,11 +29,9 @@ static size_t kunit_test_cases_len(struct kunit_case *test_cases)
>  
>  static void kunit_print_subtest_start(struct kunit_suite *suite)
>  {
> -	kunit_print_tap_version();
> -	kunit_printk_emit(LOGLEVEL_INFO, "\t# Subtest: %s\n", suite->name);
> -	kunit_printk_emit(LOGLEVEL_INFO,
> -			  "\t1..%zd\n",
> -			  kunit_test_cases_len(suite->test_cases));
> +	pr_info_once("TAP version 14\n");
> +	pr_info("\t# Subtest: %s\n", suite->name);
> +	pr_info("\t1..%zd\n", kunit_test_cases_len(suite->test_cases));
>  }
>  
>  static void kunit_print_ok_not_ok(bool should_indent,
> @@ -87,9 +51,8 @@ static void kunit_print_ok_not_ok(bool should_indent,
>  	else
>  		ok_not_ok = "not ok";
>  
> -	kunit_printk_emit(LOGLEVEL_INFO,
> -			  "%s%s %zd - %s\n",
> -			  indent, ok_not_ok, test_number, description);
> +	pr_info("%s%s %zd - %s\n",
> +		indent, ok_not_ok, test_number, description);
>  }
>  
>  static bool kunit_suite_has_succeeded(struct kunit_suite *suite)
> @@ -133,11 +96,11 @@ static void kunit_print_string_stream(struct kunit *test,
>  		kunit_err(test,
>  			  "Could not allocate buffer, dumping stream:\n");
>  		list_for_each_entry(fragment, &stream->fragments, node) {
> -			kunit_err(test, fragment->fragment);
> +			kunit_err(test, "%s", fragment->fragment);
>  		}
>  		kunit_err(test, "\n");
>  	} else {
> -		kunit_err(test, buf);
> +		kunit_err(test, "%s", buf);
>  		kunit_kfree(test, buf);
>  	}
>  }
> @@ -505,19 +468,29 @@ void kunit_cleanup(struct kunit *test)
>  	}
>  }
>  
> -void kunit_printk(const char *level,
> -		  const struct kunit *test,
> -		  const char *fmt, ...)
> +void kunit_printk(const struct kunit *test, const char *fmt, ...)
>  {
> +	char lvl[PRINTK_MAX_SINGLE_HEADER_LEN + 1] = "\0";
>  	struct va_format vaf;
>  	va_list args;
> +	int kern_level;
>  
>  	va_start(args, fmt);
>  
> +	while ((kern_level = printk_get_level(fmt)) != 0) {
> +		size_t size = printk_skip_level(fmt) - fmt;
> +
> +		if (kern_level >= '0' && kern_level <= '7') {
> +			memcpy(lvl, fmt,  size);
> +			lvl[size] = '\0';
> +		}
> +		fmt += size;
> +	}
> +
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
>  
> -	kunit_vprintk(test, level, &vaf);
> +	printk("%s\t# %s %pV\n", lvl, test->name, &vaf);
>  
>  	va_end(args);
>  }

How is this simpler?

If we are okay with dynamically adding the KERN_<LEVEL> and %pV (and I
don't think that Sergey is), then wouldn't it be easier to pass in the
kernel level as a separate parameter and then strip off all printk
headers like this:

 void kunit_printk(const char *level,
 		  const struct kunit *test,
 		  const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;

 	va_start(args, fmt);

+	fmt = printk_skip_headers(fmt);
+
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	kunit_vprintk(test, level, &vaf);
+	printk("%s\t# %s %pV\n", level, test->name, &vaf);
 
 	va_end(args);
 }

Then the kunit_printk function is much simpler, and I don't think my
header file has to change at all.

I don't know. I am clearly not an expert on this topic, but I don't see
the merit of the while loop you added above or dropping the level param.
