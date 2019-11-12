Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0425CF9467
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2019 16:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKLPfT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Nov 2019 10:35:19 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:45236 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfKLPfT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Nov 2019 10:35:19 -0500
Received: by mail-qv1-f66.google.com with SMTP id g12so6521487qvy.12;
        Tue, 12 Nov 2019 07:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tNRldxgz4nYl5RPDJ/NAtFk6gRlRZANsJvMyHZT8zB0=;
        b=U9MBiNDluw2EFplf/vIFtT0tRdk+O162DXjvx8vR8CsvnDtvF3QCPRlfyo7EFQUHVj
         2DBpAyVyMhQgaZ6im/1rtIwirsx1XLrf+1umu8oPjpDQ6U5YdmEPoWrPfGmLCeN2jYag
         2EIN5nMcNd4+R3JX932hn712zKSIaDXq8g3nZbpO++B0wOqv3jw9TdKm8tgtrhfX4Z2F
         zY6tDxDpxs/0Vh4lgA2QQAadBn/tpLWCp6nHqAl3Tw9GRpP9bMUKoLkcaN+dm5GTiHTP
         BkkJ/MmRLvla8blXHoUXrzID/u/DxyDjqwiKPd6932MdkDQktKElP7NMDfHpOGF0BCFf
         ZrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tNRldxgz4nYl5RPDJ/NAtFk6gRlRZANsJvMyHZT8zB0=;
        b=bc4/0J9cxm9yPaq2Vk/QojgSdaNz2/tI8Gmmxj6JYcANacpKxd2TGVv4Fc2jSWtIjd
         tDy3MNwmlDoAatC+zCJk7RVsyxKglIdA+YmTJoiPK85IFf22WH4OupREdpET8gAMq2qA
         ZMsBEX1y9wiVVYQEEAspn4pjON4wz6rZWSxHE+mlXMiPL903YklpD32545GWHJ8LDu/M
         uJ5kSPCAiNPN07nacdDYALgfG3YfQumM8ob8smvh+t5FPBAdsGZyUsqS+KBqBANvOvAj
         0a4nIZFnCL2w4d14cYxC8LH64PoI2ivRkcbWX+w+tYqRwx+15vVJd91BvG2vcpAUMkvO
         HVnw==
X-Gm-Message-State: APjAAAXOcStRcAI1AQBP4MaI20vNqTow7qhw7y1d292QntAydGq14FFk
        G8SLq9HbAuFz1BllapFjprA=
X-Google-Smtp-Source: APXvYqyeF8PPHnLVkZDuDDx+6Re2Boz7tRTkUjJ45TRCBTKKb+ah58UaycNjjZFn9+4BZpV1OoJK/A==
X-Received: by 2002:a0c:c211:: with SMTP id l17mr28816269qvh.55.1573572917683;
        Tue, 12 Nov 2019 07:35:17 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:f36a])
        by smtp.gmail.com with ESMTPSA id u26sm742533qkj.24.2019.11.12.07.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 07:35:16 -0800 (PST)
Date:   Tue, 12 Nov 2019 07:35:15 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Hewenliang <hewenliang4@huawei.com>
Cc:     shuah@kernel.org, guro@fb.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftests: cgroup: Avoid the reuse of fd after it is
 deallocated
Message-ID: <20191112153515.GE4163745@devbig004.ftw2.facebook.com>
References: <20191112021655.52951-1-hewenliang4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112021655.52951-1-hewenliang4@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 11, 2019 at 09:16:55PM -0500, Hewenliang wrote:
> It is necessary to set fd to -1 when inotify_add_watch() fails in
> cg_prepare_for_wait. Otherwise the fd which has been closed in
> cg_prepare_for_wait may be misused in other functions such as
> cg_enter_and_wait_for_frozen and cg_freeze_wait.
> 
> Fixes: 5313bfe425c8 ("selftests: cgroup: add freezer controller self-tests")
> Signed-off-by: Hewenliang <hewenliang4@huawei.com>

Applied to cgroup/for-5.5.

Thanks.

-- 
tejun
