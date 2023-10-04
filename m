Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FF37B8D22
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 21:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244931AbjJDTAr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 15:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245140AbjJDS6q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 14:58:46 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0C510CC;
        Wed,  4 Oct 2023 11:55:11 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-690fe10b6a4so91319b3a.3;
        Wed, 04 Oct 2023 11:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696445711; x=1697050511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRoTTT+olEk9QPCtVtm8UsKlLIAIQzhUpSB6cf5g+W4=;
        b=ELKGviabcfJvis9/3KS2V7eQjvWzWrsNyBOPj6LS5q65IkXfFNWMaty9nwAHNT8huN
         V4FEj/cUUihwgkTtnxvjHtIDb7BKFXUAeUtbEOLQak+t60omQx0G4fU+8srp2fZs0wk4
         0qKfxxStyQYcJgUJp+3aUymMpt882f9ct2Gn1LJ5hd15piiVJ6sn2eIlHokOTUerdYrE
         YhHg04zDhXCcWNBIjHNJQNJz+v1k2sLlA/nb6BYrTZmDj1yxYu8XwBCsWhWnjXJBDi49
         ydpC9cIJ8n10ahbcTKZ7Zu+BYXBEDLwEwVHgJHvUtPqRQm8SL2uofG3ylkkoIMQvOpgA
         uBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696445711; x=1697050511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRoTTT+olEk9QPCtVtm8UsKlLIAIQzhUpSB6cf5g+W4=;
        b=AfUQ8RyO12vb9cXZ0RfbIoAm2c5GhdRqq9a0prm+O0z+2qN0o1yZJYVZkDYHKjRsf9
         rs0QExupDpD8fL/DZnIznARsQ0SJFQRbeljngYVeMQqeASGnKOjGFSep1EkTRf9F6JnM
         Oeb9UOIRrkij3GISwPqvWgklzgjUQnDYgzH62gvLvfK0FnPxM3cbVajTlj4EW2mb2Mr+
         gZKrKqXIq33KjSVweY0DI99LQIG/ndFrgx7YV1OJ8bB0TwyEFfJ439OcBhNZPhQsQmHs
         bapaZ3Eg7bbVatsFNyVKWWoDJpPK/i/BqOOuljRi06inr5vkV7J55VIFXwqhVPikMhg/
         ApZA==
X-Gm-Message-State: AOJu0YytF14cvbCzS2uV32feGZdMoVzP34LGRGmB1sUj3esKTnyJwByr
        EXGuHecJFWdETRuxicKYTfP2uryyRga3Fw==
X-Google-Smtp-Source: AGHT+IGH8UOAeBNqXCXrrve+eWueFektU2xFOfxd9ExxG1b9dFbSOBg1Qrj4IRC8VsavCM7LocsfCw==
X-Received: by 2002:a05:6a20:3d85:b0:133:f0b9:856d with SMTP id s5-20020a056a203d8500b00133f0b9856dmr3619962pzi.17.1696445711098;
        Wed, 04 Oct 2023 11:55:11 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:cef])
        by smtp.gmail.com with ESMTPSA id d8-20020aa78688000000b0068fece22469sm3537444pfo.4.2023.10.04.11.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 11:55:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Oct 2023 08:55:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH-cgroup v2] cgroup/cpuset: Enable invalid to valid local
 partition transition
Message-ID: <ZR21DHx3oJJWs8AI@slm.duckdns.org>
References: <20231003144420.2895515-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003144420.2895515-1-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 03, 2023 at 10:44:20AM -0400, Waiman Long wrote:
> When a local partition becomes invalid, it won't transition back to
> valid partition automatically if a proper "cpuset.cpus.exclusive" or
> "cpuset.cpus" change is made. Instead, system administrators have to
> explicitly echo "root" or "isolated" into the "cpuset.cpus.partition"
> file at the partition root.
> 
> This patch now enables the automatic transition of an invalid local
> partition back to valid when there is a proper "cpuset.cpus.exclusive"
> or "cpuset.cpus" change.
> 
> Automatic transition of an invalid remote partition to a valid one,
> however, is not covered by this patch. They still need an explicit
> write to "cpuset.cpus.partition" to become valid again.
> 
> The test_cpuset_prs.sh test script is updated to add new test cases to
> test this automatic state transition.
> 
> Reported-by: Pierre Gondois <pierre.gondois@arm.com>
> Link: https://lore.kernel.org/lkml/9777f0d2-2fdf-41cb-bd01-19c52939ef42@arm.com
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.7.

Thanks.

-- 
tejun
