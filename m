Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8239CF4FD8
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2019 16:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfKHPfq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Nov 2019 10:35:46 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33184 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKHPfq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Nov 2019 10:35:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id h27so4206457pgn.0
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Nov 2019 07:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mbqjUWGDXWIaVy6iV3sdofZ0jxt/pVLpoh92ATrPX1Y=;
        b=vorgUDj6+6UmJsxUwlznw94CFZybpHAl2ne3wb2WfWG1z8CgLHiINfPY04JeSC+0k1
         /1ztuPLxGB1SErJB1Qvk844TfucGzjQjyH+5c+Ilc4DHUnYlFCfSYrjWcXtv6P6NNdKd
         I3tYRrSpNfjKot7F5PnRxv/1pPMmbNhi533jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mbqjUWGDXWIaVy6iV3sdofZ0jxt/pVLpoh92ATrPX1Y=;
        b=Iz64/IdhNWMRXr4vK49aNGqtIfcx69HNs4SxB1+zFN4dJrxvIdchb9y3QfMgonAj8p
         OzDxtq7i60TIedldCCg8dK2b2DqcDwGfp15jXKyu0zYaw356IiTeRAYr0Dx3T8vYB62+
         PGYiuJkZnyrtcRkNhgW+8s1PXwZpnVUL9azzpIBTvHrGhOayk1AyAM0fwZ93KgFSqJZi
         r1lQ4Gxi/wjwdy8WymJLSJSOJ/q7EX5GmoQAV8ihj2kW8XfEy1MAM6LdueNhvY+WMVPZ
         RVhwUb4FC+EN+wHWScOzAdEacO1s3+u6P3lHQVcJvZ9EGMmz1O9IqlaBoR+ulElyy0qG
         gqwQ==
X-Gm-Message-State: APjAAAUrCnILok5lbP729+onSp4ar9Sjfy8yw4BvLQLiOqiYAAXu3PSo
        yUa938t36jUNMIOrnBWrwss/fg==
X-Google-Smtp-Source: APXvYqwb/aQ3D7gYofOFDmeLVdI6s94UZkNaBx0GgMxCmDj+wJ0R0I6NwdU1Nlz6L3VGQ3sxGI1pxw==
X-Received: by 2002:a62:d44b:: with SMTP id u11mr12485806pfl.259.1573227345330;
        Fri, 08 Nov 2019 07:35:45 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j7sm5528054pgl.38.2019.11.08.07.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 07:35:44 -0800 (PST)
Date:   Fri, 8 Nov 2019 10:35:43 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Geoffray <ngeoffray@google.com>,
        kernel-team@android.com, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/2] memfd: Fix COW issue on MAP_PRIVATE and
 F_SEAL_FUTURE_WRITE mappings
Message-ID: <20191108153543.GC99567@google.com>
References: <20191107195355.80608-1-joel@joelfernandes.org>
 <20191108063308.GB18778@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108063308.GB18778@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 07, 2019 at 10:33:08PM -0800, Christoph Hellwig wrote:
> > -		 * Since the F_SEAL_FUTURE_WRITE seals allow for a MAP_SHARED
> > -		 * read-only mapping, take care to not allow mprotect to revert
> > -		 * protections.
> > +		 * Since an F_SEAL_FUTURE_WRITE sealed memfd can be mapped as
> > +		 * MAP_SHARED and read-only, take care to not allow mprotect to
> > +		 * revert protections on such mappings. Do this only for shared
> > +		 * mappings. For private mappings, don't need to mask VM_MAYWRITE
> 
> This adds an > 80 char line.

Oh, true. Sorry. Andrew I hate to ask you but since you took the patch
already, could you just the comment for the character limit in the one
you applied?

thanks,

 - Joel

