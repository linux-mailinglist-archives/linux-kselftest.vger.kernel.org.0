Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B05C3B53FB
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Jun 2021 17:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhF0P0X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Jun 2021 11:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhF0P0W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Jun 2021 11:26:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4F3C061574;
        Sun, 27 Jun 2021 08:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5TjA7PSFWDPnK1JEPwMyjrDO4IXpUkyVPH+qXipsLzI=; b=FB+cE5V6zlmQ3S9KW0NvTeKstw
        zq39qvfjji5PrG/b2xqx0jDeddwlfPRG8kdCN5zAI9uE7og3NneIPqxJNS+Z8VBRqJUTbXqBPNJ6f
        mp0NWmZOK6zAMqw9JBIZNHQf0W/cJniQ0Qtdbzn0vK1WUNMOjC2oStYpNsOdf3OeJO0g3Q/6Vqr8x
        Xj5djUGWwSgQmdJHrYN6XDqMJvgJnkkDCmdMqDYJN5sgCk409U8NTVlYqSBl64AT8fsYX5j9CJ1A0
        ShhzJ7ENznjKRUkm9EAuALLMhmTBrmyhjjt5wFZuMLJKhqw9CXG8mtUcfH9Pv3UFCA+qwt/BMPPNM
        O/+TNZUw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxWd4-0020zz-Kw; Sun, 27 Jun 2021 15:23:31 +0000
Date:   Sun, 27 Jun 2021 16:23:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 03/12] digest_lists: Basic definitions
Message-ID: <YNiX7nyQIS/eg+VC@casper.infradead.org>
References: <20210625165614.2284243-1-roberto.sassu@huawei.com>
 <20210625165614.2284243-4-roberto.sassu@huawei.com>
 <YNhYu3BXh7f9GkVk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNhYu3BXh7f9GkVk@kroah.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jun 27, 2021 at 12:53:47PM +0200, Greg KH wrote:
> > +enum ops { DIGEST_LIST_ADD, DIGEST_LIST_DEL, DIGEST_LIST_OP__LAST };
> > +
> 
> For enums you export to userspace, you need to specify the values so
> that all compilers get them right.

I've never heard that rule before.  Where does it come from?
https://en.cppreference.com/w/c/language/enum
says:

  If enumeration-constant is not followed by = constant-expression,
  its value is the value one greater than the value of the previous
  enumerator in the same enumeration. The value of the first enumerator
  (if it does not use = constant-expression) is zero.

