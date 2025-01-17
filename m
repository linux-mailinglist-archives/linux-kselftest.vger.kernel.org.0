Return-Path: <linux-kselftest+bounces-24701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 058B2A14C3C
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 10:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6899F188AE5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 09:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B841F9A9C;
	Fri, 17 Jan 2025 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QD8wbOia"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F2525A659
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737106490; cv=none; b=MOx7p5O1qOA5rglZBxE/ROpjLDK+IJtccvk9rv3buzedyR03kcH61DgcwktmoWZJlOrRJiEJrzjAMB6mpkXqPCbeLDv9EE7sobxyuvTD3blsXQcQuviF07w5MqNVp1WmbKRnO++GbgJk0pjG0IT0lezUMfO/XoTJFdTWPX8zabg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737106490; c=relaxed/simple;
	bh=ROzhD2o7A72xobVtzbAwi0xhTjfUkNwGVhZOOvl8qKE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FqlPwFQxwBd5vQxw+JXyGYiebjXdN1ZskPvwlzcC4fS3OqSwtsTkGMpQ9BgixhYCXLsTos0yL4RzzL4IDg+JdB5TMOrULc49iQlssKqMGpc1GxUl+wpBwWSHzzRo3mBYOZHn9VPrAvdT049yJTpPhDKL8EtLhoKAuuVC5mPMZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QD8wbOia; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436281c8a38so12116505e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 01:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737106487; x=1737711287; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0VVP25KPJ8YWYOOPy9jroFWWCrP0LQku/RXkcTfV8rM=;
        b=QD8wbOiaDVU+AUfiomf+c/tQJBYjoSz58WKPBLQyJ4IXTrCQnE6DH8RKOiViHerGQN
         CJ8RxwSMqedzZuj0elw1NJZCfuZpa1gUiDcAE6M4KzYgtZUCI9eLLmXbnipBuhrN2uo7
         GiqL0utbmrFoxuXQuO4MUZT7KIYAkux0DzObTn2a+4hoKBz2IwWtFTpxGYPWGakmJfDC
         6kZO91DF0o9YMwTroZet6bljSf20RO5G93c0FK5UGeTd1kXAskucvNFsvEjxH219x1kB
         E7VAv6gEnVfahVkmrZnnPfn/C0qHKabVAzQo28KroqXyVzerFzIz9MK7n8rVkWQzC4/y
         ChxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737106487; x=1737711287;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0VVP25KPJ8YWYOOPy9jroFWWCrP0LQku/RXkcTfV8rM=;
        b=m6o51mloLfnA4z//3OXNSft6oU+g6f4v6KuggR7W5ksTvJS+n/IxmO5sbkwa8Ll/d3
         eCRI2CY7QCB7ekNOkFo6GDfWcG18/OlzeGFxOuAobdq9tnbxeGOTYQCsAMHba2JppQS1
         RrwlX6qSndA5cqWBu8go/sb1CH6ltjAb9cDRl/VNpAbyTQcBiv1oGCa+3JHTnpdZe2Gp
         5cDc1NbOII/LSdm8o5q4HMFp+Y3ivWubZXnT1xzCo0tNoEXdEIpNomxfNIea3Iu9RXo/
         F7SEUNnO8N70bzY+P19gq4MrWyzFyGBG11RM7IWQTjWwlSDRiloWLfxHxPl/fsuRMO4I
         RrbQ==
X-Gm-Message-State: AOJu0YwsFW28g7d81xDYxhZwVhBOKFx7fGtfpgymjlQVo8rkppdVXTEH
	kopD8A4wxFbW4VBUMO5+Fk5F4P447q2cdKXWB+D0IQSg2Y6WPPoVc+7qboQe+9Q=
X-Gm-Gg: ASbGncvUUpYUU1Fn1bMUJYW+ogyJf2eCxtI8Tw4/moE6z9Y6Tl+WFJXYF8TXd5CFoax
	wy+yH+LNW14c93zgAvV8aceqPUYFvE6Un/KwfbEgAbLmo3BdIeIzbB/91mrvxcME8qWv7FunDhf
	fIY0p2hfrGRbLgNJamwwvPfynT6y+vFytAJX9TzRj7T3do2vz1ErxwIMr7z0FsJzV9LXKP6yZpI
	ATKWEfaNO/q2pVtwoT6kPjKv4G85p1xL+r+kUTRWjEIehhpMHH0i2znoHzLrg==
X-Google-Smtp-Source: AGHT+IGks9Il0BahmzfJdxTXVOMxUH1ttxtW9+g6SMWOe9atW9q/Xs+2ewIQYAA6IWPx2lh7RAA7Yw==
X-Received: by 2002:a5d:59a8:0:b0:385:fa26:f0d8 with SMTP id ffacd0b85a97d-38bf5655a0amr1817520f8f.8.1737106486638;
        Fri, 17 Jan 2025 01:34:46 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf327dee3sm1993570f8f.86.2025.01.17.01.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:34:46 -0800 (PST)
Date: Fri, 17 Jan 2025 12:34:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: linux-kselftest@vger.kernel.org
Subject: [bug report] selftests: ALSA: Cover userspace-driven timers with test
Message-ID: <0e9c25d3-efbd-433b-9fb1-0923010101b9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Ivan Orlov,

Commit 1026392d10af ("selftests: ALSA: Cover userspace-driven timers
with test") from Aug 13, 2024 (linux-next), leads to the following
Smatch static checker warning:

	tools/testing/selftests/alsa/utimer-test.c:135 timer_f_utimer()
	error: uninitialized symbol 'ticking_thread'.

tools/testing/selftests/alsa/utimer-test.c
   106  TEST_F(timer_f, utimer) {
   107          char command[64];
   108          pthread_t ticking_thread;
   109          int total_ticks = 0;
   110          FILE *rfp;
   111          char *buf = malloc(TIMER_OUTPUT_BUF_LEN);
   112  
   113          ASSERT_NE(buf, NULL);
   114  
   115          /* The timeout should be the ticks interval * count of ticks + some delta */
   116          sprintf(command, "./global-timer %d %d %d", SNDRV_TIMER_GLOBAL_UDRIVEN,
   117                  self->utimer_info->id, TICKS_COUNT * TIMER_FREQ_SEC + TICKS_RECORDING_DELTA);
   118  
   119          rfp = popen(command, "r");
   120          while (fgets(buf, TIMER_OUTPUT_BUF_LEN, rfp)) {
   121                  buf[TIMER_OUTPUT_BUF_LEN - 1] = 0;
   122                  switch (parse_timer_output(buf)) {
   123                  case TIMER_APP_STARTED:
   124                          /* global-timer waits for timer to trigger, so start the ticking thread */
   125                          pthread_create(&ticking_thread, NULL, ticking_func,
                                                ^^^^^^^^^^^^^^
ticking_thread is only initialized here, not on other paths.

   126                                         &self->utimer_info->fd);
   127                          break;
   128                  case TIMER_APP_RESULT:
   129                          total_ticks = parse_timer_result(buf);
   130                          break;
   131                  case TIMER_NO_EVENT:
   132                          break;
   133                  }
   134          }
   135          pthread_join(ticking_thread, NULL);
                             ^^^^^^^^^^^^^^
uninitialized.

   136          ASSERT_EQ(total_ticks, TICKS_COUNT);
   137          pclose(rfp);
   138  }

regards,
dan carpenter

