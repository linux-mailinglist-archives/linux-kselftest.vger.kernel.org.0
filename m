Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457F844D71D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Nov 2021 14:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhKKNYB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Nov 2021 08:24:01 -0500
Received: from mga06.intel.com ([134.134.136.31]:55413 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231739AbhKKNYA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Nov 2021 08:24:00 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="293732425"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="293732425"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 05:21:11 -0800
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="733179575"
Received: from thrakatuluk.fi.intel.com (HELO thrakatuluk) ([10.237.72.185])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 05:21:06 -0800
Received: from platvala by thrakatuluk with local (Exim 4.94)
        (envelope-from <petri.latvala@intel.com>)
        id 1ml9zh-0000wf-0i; Thu, 11 Nov 2021 15:19:57 +0200
Date:   Thu, 11 Nov 2021 15:19:57 +0200
From:   Petri Latvala <petri.latvala@intel.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
        daniel@fooishbar.org, igt-dev@lists.freedesktop.org,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        ~lkcamp/discussion@lists.sr.ht, isabbasso@riseup.net,
        maira.canal@usp.br, arthur.grillo@usp.br,
        linux-kernel@vger.kernel.org
Subject: Re: [igt-dev] [RFC PATCH 0/1] drm: selftest: Convert to KUnit
Message-ID: <YY0YfV4WECXFMhYw@platvala-desk.ger.corp.intel.com>
References: <20211111003453.209115-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211111003453.209115-1-andrealmeid@collabora.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 10, 2021 at 09:34:52PM -0300, André Almeida wrote:
> Hi,
> 
> This RFC is a preview of the progress we made in the KUnit hackathon[0].
> This patch, made by Maíra and Arthur, converts the damage helper test
> from the original DRM selftest framework to use the KUnit framework.
> 
> [0] https://groups.google.com/g/kunit-dev/c/YqFR1q2uZvk/m/IbvItSfHBAAJ
> 
> The IGT part of this work can be found here:
> https://gitlab.freedesktop.org/isinyaaa/igt-gpu-tools/-/tree/introduce-kunit

IGT side approach looks good. There's a couple of obscure bugs that I
spotted but nothing that is unfixable when it's time to review in
detail.


-- 
Petri Latvala
