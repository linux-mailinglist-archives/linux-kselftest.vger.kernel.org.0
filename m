Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041B11CE2BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 May 2020 20:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbgEKS2U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 May 2020 14:28:20 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35394 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbgEKS2T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 May 2020 14:28:19 -0400
Received: by mail-pj1-f68.google.com with SMTP id ms17so8199808pjb.0;
        Mon, 11 May 2020 11:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VlcIlbKUmV2Z0lZsaJ/MguViZcS3naoljRGqlVyUKTk=;
        b=DIdGTt40rE+KhPVZ8Dj006Gm6BxsQlALxQP5iFnMqad06CnyKBo2TT/hrDOxnYB5eU
         QKUQxkdIvRMTsnfkPeDVYBPXThC2rz9hEpgGt5w/fVi2WxX6Qqq2AXM68E+l6oGN7wCn
         q9+wZg9Onca0NWptpEUgwMWc+zFFAf5dE40TwEmdvLJhupTkBKU0x9tUNvr8rHv1zHsU
         GFygIJmx0rDPptG4wkrcH7Za0eOlpbtkBZ+XkrA6x4ECAa1B5acgfVQCpxJN/7Gpbl2p
         kQQk+SPkpoyr+AbnQ2bbj/ZeWcOwmp6h52lLFT57KeUHJ4aYld6mKEmf22U90wT8XJfm
         w/4w==
X-Gm-Message-State: AGi0PuY/bJrNd4JOdVCn/Aamv80l3zYJy8p85Ewbeh+Qrd/mM+96Q69b
        EbIG/Np4vsIfZRvBE0zdrlfMQfZEhJ4=
X-Google-Smtp-Source: APiQypISO15fI9lHsIZIQ9EvEPWgAkglXwXVHMxT7KKCWrrAa1iRQnwjK4EfReJHcdP1wqsU+aIbiQ==
X-Received: by 2002:a17:902:d689:: with SMTP id v9mr16640720ply.328.1589221697990;
        Mon, 11 May 2020 11:28:17 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a7sm9951520pfg.157.2020.05.11.11.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 11:28:15 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E966B40605; Mon, 11 May 2020 18:28:14 +0000 (UTC)
Date:   Mon, 11 May 2020 18:28:14 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     akpm@linux-foundation.org, jeyu@kernel.org, shuah@kernel.org,
        Markus.Elfring@web.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, lixuefeng@loongson.cn
Subject: Re: [PATCH v4 0/4] Fix some issues about kmod
Message-ID: <20200511182814.GS11244@42.do-not-panic.com>
References: <1587452704-1299-1-git-send-email-yangtiezhu@loongson.cn>
 <9b50d2b1-2fb4-10a1-5966-5458507a9b05@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b50d2b1-2fb4-10a1-5966-5458507a9b05@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 11, 2020 at 08:59:37PM +0800, Tiezhu Yang wrote:
> Hi,
> 
> Could you please apply the following three patches?
> 
> [v4,1/4] selftests: kmod: Use variable NAME in kmod_test_0001()
> https://lore.kernel.org/patchwork/patch/1227980/
> 
> [v4,2/4] kmod: Remove redundant "be an" in the comment
> https://lore.kernel.org/patchwork/patch/1227982/
> 
> [v4,4/4] test_kmod: Avoid potential double free in trigger_config_run_type()
> https://lore.kernel.org/patchwork/patch/1227978/

Andrew,

These 3 patches should be fine.

I am re-working a replacement proper fix for patch #3, that requires a
change to the umh. I'll try to iron this out today.

  Luis
