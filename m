Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC82D140FD7
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2020 18:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgAQR2K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jan 2020 12:28:10 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44003 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgAQR2K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jan 2020 12:28:10 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so22328496qtj.10;
        Fri, 17 Jan 2020 09:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YJBe+PR1JTzkbV6VdX/ClFM8UuTfYuVGKNcb10Up+LM=;
        b=DbHiqO+e6kYuR6bMRUFqkRzJXzREnc/t8WeVUwNtwBq0US0ALqFtfBS3k8Ar5PzFae
         jpbiR7Ax+NvFzgNUZfzP6b4KBWdJJ8us7/sDH5Tiro8mnHYZM1bos9P/GDhAcxVHXG4b
         +CqRW+gbtb40Tq4JQ9+XfDuAtGc8xx7XWoPbLCDa9sXO0xSMc54OuWYlMPO3hMfg3xGs
         R6SRfw70eNBH9z1vinkvQf3Pkmv//DOGZzpDO/JeaaQZKfMlTJoC34/zqw6bnCacSApd
         hf6+skAgQQBrKH5W5od7c18HNBincCZTYsXdKlpO3ehhcjXZitzgNqPGCAFsoZlAoM4q
         MvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YJBe+PR1JTzkbV6VdX/ClFM8UuTfYuVGKNcb10Up+LM=;
        b=dlGsDK2AVaRbvusaEwWxDibqJoeiK/AU65ivacLnjYcLGTxCD6VYhitgt2zmk+hptR
         MfK5Oi0TydvTAPAOfCqkA0RFxuYxHppwz0DY3K8zZDAOCrmo2XSvJ/m+pMI6IwnGzJ3y
         SGRJWwfxMcy8YdtctsVJvBwnB9dEEBhgpnYmAGhMnJEpQXDOwCUNl/gq5CnEuzmoJL0k
         /yqZPr8pRF7NKkW8KEjAUO3/EY5/P912PucbXcLVztykPCI9Xb68AjnO9Vpc8aFwyRYI
         jyGDqZvtzS6wVXn4eLQ8CGW9qjlt4QVINVasnkVXUJv4QvU1qyJFmUCOCtS6vNzRb+1Q
         jRLg==
X-Gm-Message-State: APjAAAWFfcXNO2Ha9g7lMIHhylEmtT4DU5RLAyl3XBSPtrOy+d9nyvEq
        YV5glm5kx1vtcdMj/2m6AGU=
X-Google-Smtp-Source: APXvYqz2O/xFh6ygdxVfF7TRwAgb6tMQGsH1goOEKwF730KRP0mdEDko+yi0ag0UIHTaUnjOw9qRYQ==
X-Received: by 2002:aed:2150:: with SMTP id 74mr8430727qtc.323.1579282089045;
        Fri, 17 Jan 2020 09:28:09 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:7d10])
        by smtp.gmail.com with ESMTPSA id r37sm13251937qtj.44.2020.01.17.09.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jan 2020 09:28:08 -0800 (PST)
Date:   Fri, 17 Jan 2020 09:28:06 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, alex.shi@linux.alibaba.com,
        guro@fb.com, kernel-team@android.com, linger.lee@mediatek.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        shuah@kernel.org, tomcherry@google.com
Subject: Re: [PATCH 2/3] cgroup: Iterate tasks that did not finish do_exit()
Message-ID: <20200117172806.GK2677547@devbig004.ftw2.facebook.com>
References: <20200116043612.52782-1-surenb@google.com>
 <20200117151533.12381-1-mkoutny@suse.com>
 <20200117151533.12381-3-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200117151533.12381-3-mkoutny@suse.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 17, 2020 at 04:15:32PM +0100, Michal Koutný wrote:
> PF_EXITING is set earlier than actual removal from css_set when a task
> is exitting. This can confuse cgroup.procs readers who see no PF_EXITING
> tasks, however, rmdir is checking against css_set membership so it can
> transitionally fail with EBUSY.
> 
> Fix this by listing tasks that weren't unlinked from css_set active
> lists.
> It may happen that other users of the task iterator (without
> CSS_TASK_ITER_PROCS) spot a PF_EXITING task before cgroup_exit(). This
> is equal to the state before commit c03cd7738a83 ("cgroup: Include dying
> leaders with live threads in PROCS iterations") but it may be reviewed
> later.

Yeah, this looks fine to me.  Any chance you can order this before the
clean up so that we can mark it for -stable.

Thanks.

-- 
tejun
