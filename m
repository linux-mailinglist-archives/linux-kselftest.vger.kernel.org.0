Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF5C1AEA13
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Apr 2020 07:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDRFrp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Apr 2020 01:47:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42613 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgDRFrp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Apr 2020 01:47:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id v2so1787690plp.9;
        Fri, 17 Apr 2020 22:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zMXPzz2G00ors3BfNZRm11ERgCBT+DigfAHLq5G+d6E=;
        b=j4KTIYXfjCeZt+NzF7/zYebyRor1p8f7/4wYvJSa+TR67h570WkRpENIJCHvvvMfIB
         U+KkHGRX+50gcjElIy8zn+64hgdn0pMxx0TmErfZSsY97AEXq6HZbTlHGF1GSh8XrHOH
         eQJ/ONkMSVAeLgodSTHMPs9TnxHbKhovRYsYqMMW4kSik+MDgA0xjS3AJZV+Fi/8DT6f
         cTLs2lZyDqsKvxR6UX+Y/Da8rGcUrbB628z5rwoQNG+ExHMIa0HYZhb/v6WP+cyqFlmE
         igUYRKlia5WJL2fbHb6ORZ6/2QVti1bMqmlmSQg+vLKYKA8QxuHXumm78YVmCVOWScjm
         jqew==
X-Gm-Message-State: AGi0PuYtiVp4/Ne6dqF+sJzbau2H1IICB9ErbYmhjExBpoaNX5XwOfyW
        TAYChGbUMTN+b6lJ4XgFPzk=
X-Google-Smtp-Source: APiQypI4rqzI1777TONXEgUO9HrDpEKQjITrXSrc/WVOvF/O9E41y5+IGJcGgYTG9YNxSd6MGEa4Iw==
X-Received: by 2002:a17:902:9348:: with SMTP id g8mr7033243plp.112.1587188863559;
        Fri, 17 Apr 2020 22:47:43 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id i6sm15209293pfg.138.2020.04.17.22.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 22:47:42 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 118484028E; Sat, 18 Apr 2020 05:47:42 +0000 (UTC)
Date:   Sat, 18 Apr 2020 05:47:42 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/4] test_kmod: Avoid potential double free in
 trigger_config_run_type()
Message-ID: <20200418054742.GB11244@42.do-not-panic.com>
References: <1587187200-13109-1-git-send-email-yangtiezhu@loongson.cn>
 <1587187200-13109-4-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587187200-13109-4-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Apr 18, 2020 at 01:20:00PM +0800, Tiezhu Yang wrote:
> It should set config->test_fs instead of config->test_driver as NULL
> after kfree_const(config->test_fs) to avoid potential double free.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Acked-by:  Luis Chamberlain <mcgrof@kernel.org>

   Luis
