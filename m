Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7463A9F783
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2019 02:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfH1Apq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Aug 2019 20:45:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58538 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfH1App (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Aug 2019 20:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zEBHcr/09CEKB955bmxu+097hCT7UUPXb3clVAJ4cus=; b=Eb5Wlw9GoJaa2jLtchp7QDNz1
        ubFfNEPcGO6aS/hDUCR0aVYgwMjm+a5jrrbJvwCaX1LSGsGWLOBDoPEzC9j8jdw3qRYZdVXR0OO6+
        E4ayvuE8J++OQiuPWzl7+Tafv3L75zkDwUD6PD3dJVyE48MmxSdh21aqgYkbW8eqzCU2wCH27xrqb
        EoJdG5GjhfmVxGyLHrCrUN2TttduqU4GKbj7ZPJNfexjyQPO87K9o99U8+35opV16OMnGz7hA3qFy
        Nyl7cyDxcrx87EPYLseVLUHzHmywzsLq8ER/lMmsRvh6ootGtfvia84Iekntkrc3w2A50PlNx9EVL
        K70+SEPIA==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2m5m-00034Q-1H; Wed, 28 Aug 2019 00:45:42 +0000
Subject: Re: [PATCH v1] printk: add dummy vprintk_emit for when
 CONFIG_PRINTK=n
To:     Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        sboyd@kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20190827234835.234473-1-brendanhiggins@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <29c9d723-1f4e-8d58-7adc-cd84431c3fe1@infradead.org>
Date:   Tue, 27 Aug 2019 17:45:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827234835.234473-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/27/19 4:48 PM, Brendan Higgins wrote:
> Previously vprintk_emit was only defined when CONFIG_PRINTK=y, this
> caused a build failure in kunit/test.c when CONFIG_PRINTK was not set.
> Add a no-op dummy so that callers don't have to ifdef around this.
> 
> Note: It has been suggested that this go in through the kselftest tree
> along with the KUnit patches, because KUnit depends on this. See the
> second link for the discussion on this.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
> Link: https://lore.kernel.org/linux-kselftest/ECADFF3FD767C149AD96A924E7EA6EAF977A5D82@USCULXMSG01.am.sony.com/
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  include/linux/printk.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index cefd374c47b1..85b7970615a9 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -206,6 +206,13 @@ extern void printk_safe_init(void);
>  extern void printk_safe_flush(void);
>  extern void printk_safe_flush_on_panic(void);
>  #else
> +static inline __printf(5, 0)
> +int vprintk_emit(int facility, int level,
> +		 const char *dict, size_t dictlen,
> +		 const char *fmt, va_list args)
> +{
> +	return 0;
> +}
>  static inline __printf(1, 0)
>  int vprintk(const char *s, va_list args)
>  {
> 


-- 
~Randy
