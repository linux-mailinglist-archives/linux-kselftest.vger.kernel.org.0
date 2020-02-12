Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA2815B365
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2020 23:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgBLWKF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Feb 2020 17:10:05 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:34644 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBLWKF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Feb 2020 17:10:05 -0500
Received: by mail-qv1-f66.google.com with SMTP id o18so1708596qvf.1;
        Wed, 12 Feb 2020 14:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cdFC4Sw+amJDnEOMffYysz3PsfK9sMY043rnSWe7/YM=;
        b=KAdSUhYCm4EKSCvAwuyjpY9CBE8LkbBg+RlKisgUNO2Gp0VpVBxINmGcQqUFUjWf2T
         e20M3V0f5wA5yiqnJi2kJ/EXBV0Dl6xWgNdwpVyvjdZegwbvseDkjvsZNALFZQOvhliN
         VllY7hDUn5+cDbxx2pKS+H2AG2RUHhMwPD6C1kZ8/pCoXNg93+BnJVRJKWjjhelynDeJ
         BoWhGrPYv0YnZRVCDvCWSJhQsvb757R7wMhajhvhImQpghd1/01Us6N6oEs4IfNxXmsA
         aQLsb5baITGLE4uDuw0JxWjWNyslVzFaWD2ym7uGdtGBheqZVFgDfphydU//+bVS/pn8
         WsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=cdFC4Sw+amJDnEOMffYysz3PsfK9sMY043rnSWe7/YM=;
        b=I0JBInrYOGiSik6EkE9BTjDtv2hvq2Vf+IdvTWmtO0BfgPaJs26S4CkuBj0hZXek62
         Hj0JL91r0YoKNSb5bpy7lHrRqRyydG+kt+InTSM4iU2E+rD3gINUX4f9xqO64AQFu1L4
         tvPtICedwHKTHvV+eu556bomGfQ6jGntzzb0QMDMYqGXxc4yJZK2qjFPmamxMzjzqxsF
         GA86TgT2CIjlRxWk85wTEjAXjAgkfAACi4AjoXZq7NuC6qduEanO4zI1nQ+ZK+5XT31W
         4yXwJ1sVKYWlNcpevC4h7Dfphc6M2lbaPgEslhNZkvTxzPzec8btgzipPU8ZJpuKUaoC
         86rg==
X-Gm-Message-State: APjAAAV92kRECFSqpdny/wKzxrQA3x31Sz/rMc8OAwtH7r2Tiono4eKb
        +DHlAoc4prdyMfFYaynKbo4=
X-Google-Smtp-Source: APXvYqye2t37XZd6Z9apOR3wigBgtJDxhvPSPYG/19AuNeNK60F3VhB9U+/UkRAyZrCWhH9scv8Vjw==
X-Received: by 2002:ad4:518d:: with SMTP id b13mr9041062qvp.141.1581545404154;
        Wed, 12 Feb 2020 14:10:04 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:985a])
        by smtp.gmail.com with ESMTPSA id w41sm283605qtj.49.2020.02.12.14.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 14:10:03 -0800 (PST)
Date:   Wed, 12 Feb 2020 17:10:03 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, alex.shi@linux.alibaba.com, guro@fb.com,
        hannes@cmpxchg.org, kernel-team@android.com,
        linger.lee@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mediatek@lists.infradead.org, lizefan@huawei.com,
        matthias.bgg@gmail.com, shuah@kernel.org, surenb@google.com,
        tomcherry@google.com
Subject: Re: [PATCH v2 3/3] kselftest/cgroup: add cgroup destruction test
Message-ID: <20200212221003.GI80993@mtj.thefacebook.com>
References: <20200120145635.GA30904@blackbody.suse.cz>
 <20200124114017.8363-1-mkoutny@suse.com>
 <20200124114017.8363-4-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200124114017.8363-4-mkoutny@suse.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 24, 2020 at 12:40:17PM +0100, Michal Koutný wrote:
> From: Suren Baghdasaryan <surenb@google.com>
> 
> Add new test to verify that a cgroup with dead processes can be destroyed.
> The test spawns a child process which allocates and touches 100MB of RAM
> to ensure prolonged exit. Subsequently it kills the child, waits until
> the cgroup containing the child is empty and destroys the cgroup.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> [mkoutny@suse.com: Fix typo in test_cgcore_destroy comment]
> Acked-by: Michal Koutný <mkoutny@suse.com>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Applied 2-3 to cgroup/for-5.7.

Thanks a lot for working on this!

-- 
tejun
