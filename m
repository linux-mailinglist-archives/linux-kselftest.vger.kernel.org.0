Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFE72B9FD2
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Nov 2020 02:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgKTBhZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Nov 2020 20:37:25 -0500
Received: from namei.org ([65.99.196.166]:54286 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbgKTBhY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Nov 2020 20:37:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 0AK1b15J016168;
        Fri, 20 Nov 2020 01:37:01 GMT
Date:   Fri, 20 Nov 2020 12:37:01 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
cc:     Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 2/9] landlock: Cosmetic fixes for filesystem
 management
In-Reply-To: <20201111213442.434639-3-mic@digikod.net>
Message-ID: <alpine.LRH.2.21.2011201236530.15634@namei.org>
References: <20201111213442.434639-1-mic@digikod.net> <20201111213442.434639-3-mic@digikod.net>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-1830264887-1605836222=:15634"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-1830264887-1605836222=:15634
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 11 Nov 2020, Mickaël Salaün wrote:

> Improve comments and make get_inode_object() more readable.  The kfree()
> call is correct but we should mimimize as much as possible lock windows.
> 
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>

> ---
>  security/landlock/fs.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index b67c821bb40b..33fc7ae17c7f 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -85,8 +85,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>  			return object;
>  		}
>  		/*
> -		 * We're racing with release_inode(), the object is going away.
> -		 * Wait for release_inode(), then retry.
> +		 * We are racing with release_inode(), the object is going
> +		 * away.  Wait for release_inode(), then retry.
>  		 */
>  		spin_lock(&object->lock);
>  		spin_unlock(&object->lock);
> @@ -107,21 +107,21 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>  			lockdep_is_held(&inode->i_lock));
>  	if (unlikely(object)) {
>  		/* Someone else just created the object, bail out and retry. */
> -		kfree(new_object);
>  		spin_unlock(&inode->i_lock);
> +		kfree(new_object);
>  
>  		rcu_read_lock();
>  		goto retry;
> -	} else {
> -		rcu_assign_pointer(inode_sec->object, new_object);
> -		/*
> -		 * @inode will be released by hook_sb_delete() on its
> -		 * superblock shutdown.
> -		 */
> -		ihold(inode);
> -		spin_unlock(&inode->i_lock);
> -		return new_object;
>  	}
> +
> +	rcu_assign_pointer(inode_sec->object, new_object);
> +	/*
> +	 * @inode will be released by hook_sb_delete() on its superblock
> +	 * shutdown.
> +	 */
> +	ihold(inode);
> +	spin_unlock(&inode->i_lock);
> +	return new_object;
>  }
>  
>  /* All access rights which can be tied to files. */
> 

-- 
James Morris
<jmorris@namei.org>

--1665246916-1830264887-1605836222=:15634--
