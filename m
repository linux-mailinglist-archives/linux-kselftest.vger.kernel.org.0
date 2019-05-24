Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 143E32A083
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 23:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404248AbfEXVkl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 May 2019 17:40:41 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:37282 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404176AbfEXVkl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 May 2019 17:40:41 -0400
Received: by mail-vk1-f195.google.com with SMTP id j124so2545039vkb.4;
        Fri, 24 May 2019 14:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+M61dggFpUBm+TCSYA6xi0wuFiDoyPhijq/BdxGIPBk=;
        b=KkoOGgzCIRobqWvnIcfEZiben3HUa1XuJPtePp0Fmv0tK7T+s/bXdCY3CgTdQoanWp
         vJbJXh2IIyXXJW1N5krN9UdUMiz3YkwTDzz2NY5cXDNOSk8KmMWLeAo3/y7l8nEliot1
         HMIr7kLIvhW/C4B2PUYUgSQgsr6Lem76Ef1hnRGRJMHmmqwFeRUEeuSM81t6aLa/yWpw
         3Y0iOBZVkQeFv/Wbe6W18wXw5Vyc9lkjPa8o/yCIyrVVvQClK5sbOh/QdpoEiEFPtUaT
         pV4Pvh9403nTNfRkbI/CIJpNGnZHeWHe5Mt2D4X8pGBHEKo1h3WdwpSzdOzMgfev9GWI
         3o1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+M61dggFpUBm+TCSYA6xi0wuFiDoyPhijq/BdxGIPBk=;
        b=Gnv6kbHR21hYllzjnBTd62fBT1jNN5sO9fCub4ZikVNlYQb8jUN+LQL0GAwOwpfQqF
         Squ6h+tE4cijE+2dxbOwuSkivyTZspru0PvY+39QZBEII9Q8hFs+UTeule0j8TumvB6F
         xwHVEjWig3h45PnRJZkd4F6H1kwky87AGGFHsfPiGtcLQvsV0ZXT+qLwccpYmYY+tC8J
         auImPkRKxnA1E/1lz1xY2mYr4OWdRK0yjlW+LN2jpRFcmWy/wSyT2OV/w+mHV8KvYVzk
         F0W6ji+ww+QbJbm9lLWIKGQPsePg8q2pxqlPE817LFxMnVeXnNI1cx6pFp6ycf9BP1sB
         qoHA==
X-Gm-Message-State: APjAAAXYTeACOZv4r52VRpIPNqdjed1AKu0Izk8G740kV64Ha9BVGDYE
        OjrEftEQSgET0+36HVO+ex8=
X-Google-Smtp-Source: APXvYqy7ExThNB8MzXNF1tcEeF+YKb4KPnI+iUe0LLM8xq5AJ9GFWsibPXr7oV0Z3SNqZVt4cZ/CWg==
X-Received: by 2002:a1f:24c4:: with SMTP id k187mr8034744vkk.26.1558734039565;
        Fri, 24 May 2019 14:40:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:36ab])
        by smtp.gmail.com with ESMTPSA id b10sm1842702vke.46.2019.05.24.14.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 14:40:38 -0700 (PDT)
Date:   Fri, 24 May 2019 14:40:35 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jay Kamat <jgkamat@fb.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] kselftest/cgroup: fix unexpected testing failure
 on test_memcontrol
Message-ID: <20190524214035.GG374014@devbig004.ftw2.facebook.com>
References: <20190520030140.203605-1-alex.shi@linux.alibaba.com>
 <20190520030140.203605-2-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520030140.203605-2-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

All three patches look good to me.  Please feel free to add my
acked-by.  Shuah, should I route these through cgroup tree or would
the kselftest tree be a better fit?

Thanks.

-- 
tejun
