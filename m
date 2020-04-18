Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399C91AEA10
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Apr 2020 07:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgDRFrD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Apr 2020 01:47:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39003 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgDRFrC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Apr 2020 01:47:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id k15so2143626pfh.6;
        Fri, 17 Apr 2020 22:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QdzGrXlzIBlO5F637LVCspPBYDWeU2x+27J//vrbbpI=;
        b=I45Wz2Xhb61RTILTGaggn0qX7dfGnvIB3yD3w2Moq5FEc5asjvy/YSPNMrtalUolfj
         HIK4kOdsZV5EBB3rVvaxO+T8tVgZvtpNRRAM8z1D0JAQQTT7BOHtPPLPyBOYHkWTUS03
         HbqvNje23bKcmrDSB5J84NcJWtJX1YPCWmSArjN+MNUct0YdLD+YTZwpPHKHiTaOcdth
         9Bq58rXdILPd5rfi4ag8YTViHPgIVxDgLJ1x7imAFMftND7ewmNQqt8pJ9x9jcWWrHzj
         p4nyVt92vgm7Uv2kpA1p4k3RgNqZo4OQr9AWwyFKsesDkHzf+7uuGW6PdOBQUYZ7225L
         bk2Q==
X-Gm-Message-State: AGi0PuYelXHfvxlYUPgWYYSWmQ9ULLU5RPzboAyuomukOc80kKYWKq7G
        xi40xZvIp7QLeozuW0QswBY=
X-Google-Smtp-Source: APiQypJJC+uoObH7+94IOMeh5LgjHJHw/8Txo8ap/ai2g4WvE1bZDifaTi5s4+tb3nrSsOwMmFlXGw==
X-Received: by 2002:a63:d904:: with SMTP id r4mr6593837pgg.323.1587188822415;
        Fri, 17 Apr 2020 22:47:02 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id j16sm18776924pgi.40.2020.04.17.22.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 22:47:01 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 004154028E; Sat, 18 Apr 2020 05:47:00 +0000 (UTC)
Date:   Sat, 18 Apr 2020 05:47:00 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/4] kmod: Remove redundant "be an" in the comment
Message-ID: <20200418054700.GA11244@42.do-not-panic.com>
References: <1587187200-13109-1-git-send-email-yangtiezhu@loongson.cn>
 <1587187200-13109-2-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587187200-13109-2-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Apr 18, 2020 at 01:19:58PM +0800, Tiezhu Yang wrote:
> There exists redundant "be an" in the comment, remove it.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
