Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 423E8F61B9
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2019 23:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfKIWXe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 9 Nov 2019 17:23:34 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:46340 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfKIWXe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 9 Nov 2019 17:23:34 -0500
Received: by mail-pf1-f176.google.com with SMTP id 193so7501180pfc.13
        for <linux-kselftest@vger.kernel.org>; Sat, 09 Nov 2019 14:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7wtzrvWMQJd81rSyctV04BJqmx11IEbyR2DHeP80/ZI=;
        b=W2HXDkMZIAw9FZvegzZXMC7OV0Er+l7GyNimEjqwn1Cbo7Z99r/SEUEawf8vJC2VwM
         +f/NeTJPF3n1IF0pagu83g74hNZllJ6aVa9pm40lnryOd0JnFXsZTQubCph02sotGqmn
         30So26JfDQvcCLWgB/+UwUI8NzgFX35wIhgREQHmPul2ng1CfFHaqiAo4UH/LLnUU1xN
         VLvsVy397+GOXIBBzeDgPfSbw7NWVREFmSpdsXgYM0s2lKMSU9QQguJlAmx5XKi1C7c/
         KO1icQPsfTjerRAm4igsI5ox71wqAhkSBe2E/2NPIJAG96DBL6zQvsX8FpW/+ZsEhucN
         3xTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7wtzrvWMQJd81rSyctV04BJqmx11IEbyR2DHeP80/ZI=;
        b=PaI5WZfsQWYAIDEALXqoGt1EBtj4gX32bCVgq4tDQghDUWUvV+ux8KBuJpYvrZkvyW
         vYDth4D14cmvql8/byGPaZmwedZIi+Qt4Udcj7sV0GcOadn2j8OJPpUwiBfVdALldpm/
         96sE8GtmVwRREt6SsKNaBBNWnJJdP7qcRWpKJvPQ6/VFJjJMTuCo4fBzifEt3ui4aaGa
         FEWPZsDiO71W3vR2n04jSqxJNAUkS0GlrnMjh1IXFqL0Xm8o4/iQP6kh2fwAii+svHuW
         yM4hdhnw8FOLHg1Oy3X28V2VqjmkuxTKVJR6SWlDzq0yPz3dvT2dZ0sBu1uQYZMWMmib
         TFJg==
X-Gm-Message-State: APjAAAUDaejrS/1w0fUQZEGcucKpc5mp9xtOEobdoz/S6qUIcA/jGSCu
        bUUDrk5thsnNTS/UgzErfBI2zYoJsJA=
X-Google-Smtp-Source: APXvYqwu8OcjM45ZelCRjEZDgZh7/Fkw3ep9aFInXFhW5EMotAV1XpXz0jA/2xM+ylb2NC5TbZ8XQQ==
X-Received: by 2002:a17:90a:2947:: with SMTP id x7mr23696939pjf.136.1573338211304;
        Sat, 09 Nov 2019 14:23:31 -0800 (PST)
Received: from debian ([122.174.231.44])
        by smtp.gmail.com with ESMTPSA id y8sm9583372pfl.8.2019.11.09.14.23.28
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 14:23:30 -0800 (PST)
Date:   Sun, 10 Nov 2019 03:53:25 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     linux-kselftest@vger.kernel.org
Subject: test
Message-ID: <20191109222325.GA21862@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

text test
