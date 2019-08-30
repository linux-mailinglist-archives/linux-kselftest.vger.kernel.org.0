Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 880EEA3F1A
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 22:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfH3UrA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 16:47:00 -0400
Received: from smtprelay0233.hostedemail.com ([216.40.44.233]:46449 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728079AbfH3UrA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 16:47:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 82D1E18024542;
        Fri, 30 Aug 2019 20:46:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::,RULES_HIT:1:2:41:69:305:355:379:599:800:960:966:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1593:1594:1605:1730:1747:1777:1792:2196:2199:2393:2525:2553:2559:2563:2682:2685:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4051:4250:4321:4385:4605:5007:6119:6690:6742:7514:7807:7862:7875:7903:7974:8603:8660:9025:9389:10004:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12555:12663:12683:12740:12760:12895:13148:13161:13229:13230:13439:14096:14097:14659:21060:21063:21080:21324:21433:21451:21611:21627:21740:21749:21796:21939:30012:30029:30034:30036:30054:30075:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: room74_212aeb625e22
X-Filterd-Recvd-Size: 10213
Received: from XPS-9350.home (unknown [47.151.137.30])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Fri, 30 Aug 2019 20:46:54 +0000 (UTC)
Message-ID: <bc688b00b2995e4b11229c3d4d90f532e00792c7.camel@perches.com>
Subject: Re: [PATCH v2] kunit: fix failure to build without printk
From:   Joe Perches <joe@perches.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah <shuah@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        sboyd@kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Fri, 30 Aug 2019 13:46:52 -0700
In-Reply-To: <20190830183821.GA30306@google.com>
References: <20190828093143.163302-1-brendanhiggins@google.com>
         <20190828094929.GA14038@jagdpanzerIV>
         <8b2d63bf-56cd-e8f5-e8ee-2891c2c1be8f@kernel.org>
         <f2d5b474411b2940d62198490f06e77890fbdb32.camel@perches.com>
         <20190830183821.GA30306@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2019-08-30 at 11:38 -0700, Brendan Higgins wrote:
> On Thu, Aug 29, 2019 at 09:44:58PM -0700, Joe Perches wrote:
> > On Thu, 2019-08-29 at 11:01 -0600, shuah wrote:
> > > On 8/28/19 3:49 AM, Sergey Senozhatsky wrote:
> > > > On (08/28/19 02:31), Brendan Higgins wrote:
> > > > [..]
> > > > > Previously KUnit assumed that printk would always be present, which is
> > > > > not a valid assumption to make. Fix that by removing call to
> > > > > vprintk_emit, and calling printk directly.
> > > > > 
> > > > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > > > Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
> > > > > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > > Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> > > > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > > 
> > > > [..]
> > > > 
> > > > > -static void kunit_vprintk(const struct kunit *test,
> > > > > -			  const char *level,
> > > > > -			  struct va_format *vaf)
> > > > > -{
> > > > > -	kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
> > > > > -}
> > > > 
> > > > This patch looks good to me. I like the removal of recursive
> > > > vsprintf() (%pV).
> > > > 
> > > > 	-ss
> > > > 
> > > 
> > > Hi Sergey,
> > > 
> > > What are the guidelines for using printk(). I recall some discussion
> > > about not using printk(). I am seeing the following from checkpatch
> > > script:
> > > 
> > > 
> > > WARNING: Prefer [subsystem eg: netdev]_level([subsystem]dev, ... then 
> > > dev_level(dev, ... then pr_level(...  to printk(KERN_LEVEL ...
> > > #105: FILE: include/kunit/test.h:343:
> > > +	printk(KERN_LEVEL "\t# %s: " fmt, (test)->name, ##__VA_ARGS__)
> > > 
> > > 
> > > Is there supposed to be pr_level() - I can find dev_level()
> > > 
> > > cc'ing Joe Perches for his feedback on this message recommending
> > > pr_level() which isn't in 5.3.
> > 
> > I don't care for pr_level or KERN_LEVEL in a printk.
> 
> I don't think I follow, how does your version fix this?
> 
> > I think this is somewhat overly complicated.
> > 
> > I think I'd write it like:
> > ---
> >  include/kunit/test.h | 11 ++++-----
> >  kunit/test.c         | 69 ++++++++++++++++------------------------------------
> >  2 files changed, 26 insertions(+), 54 deletions(-)
> > 
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 8b7eb03d4971..aa4abf0a22a5 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -339,9 +339,8 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
> >  
> >  void kunit_cleanup(struct kunit *test);
> >  
> > -void __printf(3, 4) kunit_printk(const char *level,
> > -				 const struct kunit *test,
> > -				 const char *fmt, ...);
> > +__printf(2, 3)
> > +void kunit_printk(const struct kunit *test, const char *fmt, ...);
> >  
> >  /**
> >   * kunit_info() - Prints an INFO level message associated with @test.
> > @@ -353,7 +352,7 @@ void __printf(3, 4) kunit_printk(const char *level,
> >   * Takes a variable number of format parameters just like printk().
> >   */
> >  #define kunit_info(test, fmt, ...) \
> > -	kunit_printk(KERN_INFO, test, fmt, ##__VA_ARGS__)
> > +	kunit_printk(test, KERN_INFO fmt, ##__VA_ARGS__)
> >  
> >  /**
> >   * kunit_warn() - Prints a WARN level message associated with @test.
> > @@ -364,7 +363,7 @@ void __printf(3, 4) kunit_printk(const char *level,
> >   * Prints a warning level message.
> >   */
> >  #define kunit_warn(test, fmt, ...) \
> > -	kunit_printk(KERN_WARNING, test, fmt, ##__VA_ARGS__)
> > +	kunit_printk(test, KERN_WARNING fmt, ##__VA_ARGS__)
> >  
> >  /**
> >   * kunit_err() - Prints an ERROR level message associated with @test.
> > @@ -375,7 +374,7 @@ void __printf(3, 4) kunit_printk(const char *level,
> >   * Prints an error level message.
> >   */
> >  #define kunit_err(test, fmt, ...) \
> > -	kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
> > +	kunit_printk(test, KERN_ERR fmt, ##__VA_ARGS__)
> >  
> >  /**
> >   * KUNIT_SUCCEED() - A no-op expectation. Only exists for code clarity.
> > diff --git a/kunit/test.c b/kunit/test.c
> > index b2ca9b94c353..ddb9bffb5a5d 100644
> > --- a/kunit/test.c
> > +++ b/kunit/test.c
> > @@ -16,40 +16,6 @@ static void kunit_set_failure(struct kunit *test)
> >  	WRITE_ONCE(test->success, false);
> >  }
> >  
> > -static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
> > -{
> > -	return vprintk_emit(0, level, NULL, 0, fmt, args);
> > -}
> > -
> > -static int kunit_printk_emit(int level, const char *fmt, ...)
> > -{
> > -	va_list args;
> > -	int ret;
> > -
> > -	va_start(args, fmt);
> > -	ret = kunit_vprintk_emit(level, fmt, args);
> > -	va_end(args);
> > -
> > -	return ret;
> > -}
> > -
> > -static void kunit_vprintk(const struct kunit *test,
> > -			  const char *level,
> > -			  struct va_format *vaf)
> > -{
> > -	kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
> > -}
> > -
> > -static void kunit_print_tap_version(void)
> > -{
> > -	static bool kunit_has_printed_tap_version;
> > -
> > -	if (!kunit_has_printed_tap_version) {
> > -		kunit_printk_emit(LOGLEVEL_INFO, "TAP version 14\n");
> > -		kunit_has_printed_tap_version = true;
> > -	}
> > -}
> > -
> >  static size_t kunit_test_cases_len(struct kunit_case *test_cases)
> >  {
> >  	struct kunit_case *test_case;
> > @@ -63,11 +29,9 @@ static size_t kunit_test_cases_len(struct kunit_case *test_cases)
> >  
> >  static void kunit_print_subtest_start(struct kunit_suite *suite)
> >  {
> > -	kunit_print_tap_version();
> > -	kunit_printk_emit(LOGLEVEL_INFO, "\t# Subtest: %s\n", suite->name);
> > -	kunit_printk_emit(LOGLEVEL_INFO,
> > -			  "\t1..%zd\n",
> > -			  kunit_test_cases_len(suite->test_cases));
> > +	pr_info_once("TAP version 14\n");
> > +	pr_info("\t# Subtest: %s\n", suite->name);
> > +	pr_info("\t1..%zd\n", kunit_test_cases_len(suite->test_cases));
> >  }
> >  
> >  static void kunit_print_ok_not_ok(bool should_indent,
> > @@ -87,9 +51,8 @@ static void kunit_print_ok_not_ok(bool should_indent,
> >  	else
> >  		ok_not_ok = "not ok";
> >  
> > -	kunit_printk_emit(LOGLEVEL_INFO,
> > -			  "%s%s %zd - %s\n",
> > -			  indent, ok_not_ok, test_number, description);
> > +	pr_info("%s%s %zd - %s\n",
> > +		indent, ok_not_ok, test_number, description);
> >  }
> >  
> >  static bool kunit_suite_has_succeeded(struct kunit_suite *suite)
> > @@ -133,11 +96,11 @@ static void kunit_print_string_stream(struct kunit *test,
> >  		kunit_err(test,
> >  			  "Could not allocate buffer, dumping stream:\n");
> >  		list_for_each_entry(fragment, &stream->fragments, node) {
> > -			kunit_err(test, fragment->fragment);
> > +			kunit_err(test, "%s", fragment->fragment);
> >  		}
> >  		kunit_err(test, "\n");
> >  	} else {
> > -		kunit_err(test, buf);
> > +		kunit_err(test, "%s", buf);
> >  		kunit_kfree(test, buf);
> >  	}
> >  }
> > @@ -505,19 +468,29 @@ void kunit_cleanup(struct kunit *test)
> >  	}
> >  }
> >  
> > -void kunit_printk(const char *level,
> > -		  const struct kunit *test,
> > -		  const char *fmt, ...)
> > +void kunit_printk(const struct kunit *test, const char *fmt, ...)
> >  {
> > +	char lvl[PRINTK_MAX_SINGLE_HEADER_LEN + 1] = "\0";
> >  	struct va_format vaf;
> >  	va_list args;
> > +	int kern_level;
> >  
> >  	va_start(args, fmt);
> >  
> > +	while ((kern_level = printk_get_level(fmt)) != 0) {
> > +		size_t size = printk_skip_level(fmt) - fmt;
> > +
> > +		if (kern_level >= '0' && kern_level <= '7') {
> > +			memcpy(lvl, fmt,  size);
> > +			lvl[size] = '\0';
> > +		}
> > +		fmt += size;
> > +	}
> > +
> >  	vaf.fmt = fmt;
> >  	vaf.va = &args;
> >  
> > -	kunit_vprintk(test, level, &vaf);
> > +	printk("%s\t# %s %pV\n", lvl, test->name, &vaf);
> >  
> >  	va_end(args);
> >  }
> 
> How is this simpler?
> 
> If we are okay with dynamically adding the KERN_<LEVEL> and %pV (and I
> don't think that Sergey is),

Sergey may well be in the minority overall as %pV
is now very frequently
used throughout the kernel.

$ git grep "%pV" | wc -l
241

 then wouldn't it be easier to pass in the
> kernel level as a separate parameter and then strip off all printk
> headers like this:

Depends on whether or not you care for overall
object size.  Consolidated formats with the
embedded KERN_<LEVEL> like suggested are smaller
overall object size.

This style is also already used in the kernel.

> I don't know. I am clearly not an expert on this topic, but I don't see
> the merit of the while loop you added above or dropping the level param.

The while use is only to avoid misuses with consecutive 
KERN_<LEVEL> formats, which had happened in the past.

